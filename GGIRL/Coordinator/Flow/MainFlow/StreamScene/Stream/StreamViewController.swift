
//  StreamViewController.swift
//  GGIRL
//
//  Created by VARVAR on 20.02.2019.
//  Copyright © 2019 GoodGame. All rights reserved.


import RxCocoa
import RxSwift
import HaishinKit
import UIKit
import AVFoundation
import Photos
import VideoToolbox

class StreamViewController: CustomViewController<StreamView> {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        logger.info("1")
        if AppUtility.Orientation.isLandscape || AppUtility.Orientation.isPortrait {
            logger.info("2")
            AppUtility.Orientation.current = UIDevice.current.orientation
            if !Preference.shared.video.isOrientationLocked {
                logger.info("3")
                let currentInterfaceOrient = AppUtility.Orientation.current.interfaceOrientation
                guard currentInterfaceOrient != .unknown else { return }
                logger.info("3")
                streamSettings.orientation = AVCaptureVideoOrientation(intefraceOrientation: currentInterfaceOrient)
                logger.info("[orientation] interface = \(currentInterfaceOrient.rawValue) | video = \(streamSettings.orientation.rawValue) ")
                let videoSize = Preference.shared.video.resolution.size
                if [UIInterfaceOrientation.portrait, UIInterfaceOrientation.portraitUpsideDown].contains(currentInterfaceOrient) {
                    logger.info("4.1")
                    streamSettings.videoSettings = [
                        "width": videoSize.small,
                        "height": videoSize.big,
                    ]
                } else {
                    logger.info("4.2")
                    streamSettings.videoSettings = [
                        "width": videoSize.big,
                        "height": videoSize.small,
                    ]
                }
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    let disposeBag = DisposeBag()
    private var viewModel: StreamViewModel!

    var chatViewController: ChatViewController!

    var streamView: GLHKView!
    var rtmpConnection = RTMPConnection()
    var streamSettings: RTMPStream!
    var sharedObject: RTMPSharedObject!

    var openSettings: Bool = false

    func injectViewModel(viewModel: StreamViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.info()
        prepareChildVCs()
        setupStreamSettings()
        setupBindings()
    }

    func prepareChildVCs() {
        logger.info()
        let chatVC = ChatViewController()
        add(child: chatVC, into: rootView.chatContainer)
        chatVC.rootView.edgesToSuperview()
        self.chatViewController = chatVC
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.info()
        if openSettings {
            openSettings = false
            if Preference.shared.stream.status == .offline {
                updateCaptureSettings()
            }
        } else {
            setupStreamView()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.info()
        if !openSettings {
            logger.info()
            streamSettings.close()
            streamSettings.dispose()
            AppUtility.Orientation.lockOrientation([.all])
        }
    }

    func setupStreamSettings() {
        logger.info()
        streamSettings = RTMPStream(connection: rtmpConnection)
        streamSettings.syncOrientation = false
        logger.info(Preference.shared.video.stabilization)
        streamSettings.captureSettings = [
            "sessionPreset": Preference.shared.video.resolution.preset,
            "continuousAutofocus": Preference.shared.hardware.autofocus,
            "continuousExposure": Preference.shared.hardware.exposure,
            "fps": Preference.shared.video.fps,
            "preferredVideoStabilizationMode": Preference.shared.video.stabilization
        ]
        streamSettings.videoSettings = [
            "bitrate": Preference.shared.video.bitrate,
            "width": Preference.shared.video.resolution.size.small,
            "height": Preference.shared.video.resolution.size.big,
            "profileLevel": kVTProfileLevel_H264_Baseline_AutoLevel,
            "maxKeyFrameIntervalDuration": 2
        ]
        streamSettings.audioSettings = [
            "muted": !Preference.shared.hardware.microphone,
            "sampleRate": Preference.shared.audio.rate.samplerate,
            "bitrate": Preference.shared.audio.rate.bitrate
        ]
        streamSettings.mixer.recorder.delegate = RemoveOnFinishRecorderDelegate.default
    }
    
    func updateCaptureSettings() {
        streamSettings.captureSettings["sessionPreset"] = Preference.shared.video.resolution.preset
        streamSettings.captureSettings["fps"] = Preference.shared.video.fps
        streamSettings.captureSettings["preferredVideoStabilizationMode"] = Preference.shared.video.stabilization
        streamSettings.videoSettings["bitrate"] = Preference.shared.video.bitrate
        if AppUtility.Orientation.current.isPortrait {
            streamSettings.videoSettings["width"] = Preference.shared.video.resolution.size.small
            streamSettings.videoSettings["height"] = Preference.shared.video.resolution.size.big
        } else {
            streamSettings.videoSettings["width"] = Preference.shared.video.resolution.size.big
            streamSettings.videoSettings["height"] = Preference.shared.video.resolution.size.small
        }
        streamSettings.audioSettings["sampleRate"] = Preference.shared.audio.rate.samplerate
        streamSettings.audioSettings["bitrate"] = Preference.shared.audio.rate.bitrate
        
    }
    
    func setupStreamView() {
        logger.info()
        streamView = GLHKView(frame: rootView.bounds)
        rootView.insertSubview(streamView, at: 0)
        streamView.edgesToSuperview()
        streamView.videoGravity = AVLayerVideoGravity.resizeAspectFill
        streamSettings.attachAudio(AVCaptureDevice.default(for: .audio)) { error in
            logger.error(error.description)
        }
        streamSettings.attachCamera(DeviceUtil.device(withPosition: .back)) { error in
            logger.error(error.description)
        }
        streamView.attachStream(streamSettings)
    }

    func orientationDidChange() {
    }

    func togglePublish() {
        logger.info("streamVC > togglePublish() -> rtmp status: \(rtmpConnection.connected) | status == \(Preference.shared.stream.status)")
        switch Preference.shared.stream.status {
        case .offline:
            UIApplication.shared.isIdleTimerDisabled = true
            Preference.shared.stream.status = .connecting
            rtmpConnection.addEventListener(Event.RTMP_STATUS, selector: #selector(rtmpStatusHandler), observer: self)
            rtmpConnection.connect("rtmp://msk.goodgame.ru:1940/live")
        case .online, .connecting:
            UIApplication.shared.isIdleTimerDisabled = false
            rtmpConnection.close()
            rtmpConnection.removeEventListener(Event.RTMP_STATUS, selector: #selector(rtmpStatusHandler), observer: self)
            chatViewController.chatToggle = false
            Preference.shared.stream.status = .offline
            rootView.topControlBar.handleStreamState()
        }
    }

    func toggleMicro() {
        logger.info("Microphone oldstate : \(Preference.shared.hardware.microphone)")
        Preference.shared.hardware.microphone.toggle()
        logger.info("Microphone newState : \(Preference.shared.hardware.microphone)")
        streamSettings.audioSettings["muted"] = !Preference.shared.hardware.microphone
        rootView.bottomControlBar.handleMicroState(Preference.shared.hardware.microphone)
    }

    func toggleTorch() {
        Preference.shared.hardware.torch.toggle()
        streamSettings.torch = Preference.shared.hardware.torch
        rootView.bottomControlBar.handleTorchState(Preference.shared.hardware.torch)
    }

    func switchCam() {
        let currentPosition = Preference.shared.hardware.camera
        Preference.shared.hardware.camera = currentPosition == .back ? .front : .back
        streamSettings.attachCamera(DeviceUtil.device(withPosition: Preference.shared.hardware.camera))

    }

    func lockOrientation() {
        if Preference.shared.video.isOrientationLocked {
            AppUtility.Orientation.lockOrientation(.all, andRotateTo: AppUtility.Orientation.current.interfaceOrientation)
        } else {
            AppUtility.Orientation.lockOrientation(AppUtility.Orientation.current.interfaceOrientation.orientationMask)
        }
        Preference.shared.video.isOrientationLocked.toggle()
        rootView.bottomControlBar.handleLockOrientationState(Preference.shared.video.isOrientationLocked)
    }
    
    func pause() {
        if Preference.shared.stream.status == .online {
            streamSettings.togglePause()
            //TODO: fix handle pause and restore mic and torch
            Preference.shared.hardware.microphone = true
            Preference.shared.hardware.torch = false
            rootView.bottomControlBar.handlePauseState()
        }
    }

    func setupBindings() {
        NotificationCenter.default
            .rx.notification(UIDevice.orientationDidChangeNotification)
            .subscribe(onNext: {[weak self] _ in self?.orientationDidChange()})
            .disposed(by: disposeBag)

        rootView.topControlBar.publishButton
            .rx.tap
            .asDriver()
            .debug("publishButton")
            .drive(onNext: { [weak self] in
                self?.togglePublish()
            }).disposed(by: disposeBag)

        rootView.topControlBar.settingsButton
            .rx.tap
            .asDriver()
            .debug("settingsButton")
            .do(onNext: {self.openSettings = true})
            .drive(viewModel.inputs.tapSettings)
            .disposed(by: disposeBag)

        rootView.bottomControlBar.toggleMicroButton
            .rx.tap
            .asDriver()
            .debug("toggleMicroButton")
            .drive(onNext: { [weak self] in
                self?.toggleMicro()
            }).disposed(by: disposeBag)

        rootView.bottomControlBar.toggleTorchButton
            .rx.tap
            .asDriver()
            .debug("toggleTorchButton")
            .drive(onNext: { [weak self] in
                self?.toggleTorch()
            }).disposed(by: disposeBag)

        rootView.bottomControlBar.switchCameraButton
            .rx.tap
            .asDriver()
            .debug("switchCameraButton")
            .drive(onNext: { [weak self] in
                self?.switchCam()
            }).disposed(by: disposeBag)

        rootView.bottomControlBar.lockOrientationButton
            .rx.tap
            .asDriver()
            .debug("lockOrientationButton")
            .drive(onNext: { [weak self] in
                self?.lockOrientation()
            }).disposed(by: disposeBag)

        rootView.bottomControlBar.pauseButton
            .rx.tap
            .asDriver()
            .debug("pauseButton")
            .drive(onNext: { [weak self] in
                self?.pause()
            }).disposed(by: disposeBag)
    }

    @objc
    func rtmpStatusHandler(_ notification: Notification) {
        let e = Event.from(notification)
        if let data: ASObject = e.data as? ASObject, let code: String = data["code"] as? String {
            if code == RTMPConnection.Code.connectSuccess.rawValue {
                streamSettings.publish(Preference.shared.stream.streamKey)
                chatViewController.chatToggle = true
                Preference.shared.stream.status = .online
                rootView.topControlBar.handleStreamState()
            }
        }
    }
}

final class RemoveOnFinishRecorderDelegate: DefaultAVRecorderDelegate {
    static let `default` = RemoveOnFinishRecorderDelegate()
    override func didFinishWriting(_ recorder: AVRecorder) {
        guard let writer: AVAssetWriter = recorder.writer else { return }
        PHPhotoLibrary.shared().performChanges({() -> Void in
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: writer.outputURL)
        }, completionHandler: { _, error -> Void in
            do {
                try FileManager.default.removeItem(at: writer.outputURL)
            } catch {
                print(error)
            }
        })
    }
}
