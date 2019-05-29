////
////  StreamVC.swift
////  GGIRL
////
////  Created by Alexey on 17/05/2019.
////  Copyright © 2019 GoodGame. All rights reserved.
////
//
//import UIKit
//import RxCocoa
//import RxSwift
//import AVFoundation
//import Photos
//import VideoToolbox
//import LFLiveKit
//
//class StreamViewController: CustomViewController<StreamView>, LFLiveSessionDelegate {
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        //set outputImageOrientation & LFLiveVideoConfiguration videoSize
//        print("[Info] StreamVC > viewWillTransition")
//        print("session: \(session) , streamInfo: \(session.streamInfo), videoConfiguration: \(session.streamInfo?.videoConfiguration)")
//        switch UIDevice.current.orientation {
//        case .portrait:
//            print("[Info] StreamVC > viewWillTransition to portrait")
//            session.streamInfo?.videoConfiguration.outputImageOrientation = .portrait
//            
//        case .landscapeRight:
//            print("[Info] StreamVC > viewWillTransition to landRight")
//            session.streamInfo?.videoConfiguration.outputImageOrientation = .landscapeLeft
//            
//        case .landscapeLeft:
//            print("[Info] StreamVC > viewWillTransition to landLeft")
//            session.streamInfo?.videoConfiguration.outputImageOrientation = .landscapeRight
//        default:
//            break
//        }
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//
//    let disposeBag = DisposeBag()
//    private var viewModel: StreamViewModel!
//
//    var chatViewController: ChatViewController!
//
//    var willOpenSettings: Bool = false
//
//    func injectViewModel(viewModel: StreamViewModel) {
//        self.viewModel = viewModel
//    }
//
//    lazy var session: LFLiveSession = {
//        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: LFLiveAudioQuality.high)
//        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .high3, outputImageOrientation: .portrait)
//        videoConfiguration?.autorotate = true
//        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
//        session!.delegate = self
//        session!.preView = self.rootView.cameraPreview
//        return session!
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        logger.info()
//        
//        AppUtility.Orientation.lockOrientation([.all])
//        
//        self.requestAccessForVideo()
//        self.requestAccessForAudio()
//        
//        session.captureDevicePosition = .back
//        
//        prepareChildVCs()
//        setupBindings()
//    }
//
//    func prepareChildVCs() {
//        logger.info()
//        let chatVC = ChatViewController()
//        add(child: chatVC, into: rootView.chatContainer)
//        chatVC.rootView.edgesToSuperview()
//        self.chatViewController = chatVC
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        logger.info()
//        if willOpenSettings {
//            willOpenSettings = false
//        } else {
//            setupStreamView()
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        logger.info()
//        if !willOpenSettings {
//            logger.info()
//            AppUtility.Orientation.lockOrientation([.portrait])
//        }
//    }
//
//    func requestAccessForVideo() -> Void {
//        let status = AVCaptureDevice.authorizationStatus(for: .video);
//        switch status  {
//        case AVAuthorizationStatus.notDetermined:
//            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
//                if(granted){
//                    DispatchQueue.main.async {
//                        self.session.running = true
//                    }
//                }
//            })
//            break
//        case AVAuthorizationStatus.authorized:
//            session.running = true
//        case AVAuthorizationStatus.denied: break
//        case AVAuthorizationStatus.restricted:break
//        default:
//            break
//        }
//    }
//
//    func requestAccessForAudio() -> Void {
//        let status = AVCaptureDevice.authorizationStatus(for: .audio);
//        switch status  {
//        case AVAuthorizationStatus.notDetermined:
//            AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (granted) in
//            })
//            break
//        case AVAuthorizationStatus.authorized:
//            break
//        case AVAuthorizationStatus.denied:
//            break
//        case AVAuthorizationStatus.restricted:
//            break
//        default:
//            break
//        }
//    }
//
//    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
//        print("debugInfo: \(String(describing: debugInfo?.currentBandwidth))")
//    }
//
//    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
//        print("errorCode: \(errorCode.rawValue)")
//    }
//
//    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
//        print("liveStateDidChange: \(state.rawValue)")
//        switch state {
//        case LFLiveState.ready:
//            break
//        case LFLiveState.pending:
//            break
//        case LFLiveState.start:
//            rootView.topControlBar.handleStreamState()
//            break
//        case LFLiveState.error:
//            break
//        case LFLiveState.stop:
//            break
//        default:
//            break
//        }
//    }
//    
//    func setupRTMP() {
//        logger.info()
//    }
//
//    func setupStreamView() {
//        logger.info()
//    }
//
//    func orientationDidChange() {
//    }
////rtmp://msk.goodgame.ru:1940/live/127730?pwd=141750aa44996c35
//    func togglePublish() {
//        switch Preference.shared.stream.status {
//        case .offline:
//            UIApplication.shared.isIdleTimerDisabled = true
//            Preference.shared.stream.status = .connecting
//            let stream = LFLiveStreamInfo()
//            stream.url = "rtmp://msk.goodgame.ru:1940/live/127730?pwd=141750aa44996c35"
//            session.startLive(stream)
//        case .online, .connecting:
//            session.stopLive()
//            UIApplication.shared.isIdleTimerDisabled = false
//            Preference.shared.stream.status = .offline
//            chatViewController.chatToggle = false
//            rootView.topControlBar.handleStreamState()
//        }
//    }
//
//    func toggleMicro() {
//        logger.info("Microphone oldstate : \(Preference.shared.hardware.microphone)")
//        Preference.shared.hardware.microphone.toggle()
//        logger.info("Microphone newState : \(Preference.shared.hardware.microphone)")
//        rootView.bottomControlBar.handleMicroState(Preference.shared.hardware.microphone)
//    }
//
//    func toggleTorch() {
//        Preference.shared.hardware.torch.toggle()
//        rootView.bottomControlBar.handleTorchState(Preference.shared.hardware.torch)
//    }
//
//    func switchCam() {
//        let currentPosition = Preference.shared.hardware.camera
//        Preference.shared.hardware.camera = currentPosition == .back ? .front : .back
//    }
//
//    func lockOrientation() {
//
//    }
//
//    func pause() {
//        if Preference.shared.stream.status == .online {
//            //TODO: fix handle pause and restore mic and torch
//            Preference.shared.hardware.microphone = true
//            Preference.shared.hardware.torch = false
//            rootView.bottomControlBar.handlePauseState()
//        }
//    }
//
//    func setupBindings() {
//        rootView.topControlBar.publishButton
//            .rx.tap
//            .asDriver()
//            .debug("publishButton")
//            .drive(onNext: { [weak self] in
//                self?.togglePublish()
//            }).disposed(by: disposeBag)
//
//        rootView.topControlBar.settingsButton
//            .rx.tap
//            .asDriver()
//            .debug("settingsButton")
//            .do(onNext: {self.willOpenSettings = true})
//            .drive(viewModel.inputs.tapSettings)
//            .disposed(by: disposeBag)
//
//        rootView.bottomControlBar.toggleMicroButton
//            .rx.tap
//            .asDriver()
//            .debug("toggleMicroButton")
//            .drive(onNext: { [weak self] in
//                self?.toggleMicro()
//            }).disposed(by: disposeBag)
//
//        rootView.bottomControlBar.toggleTorchButton
//            .rx.tap
//            .asDriver()
//            .debug("toggleTorchButton")
//            .drive(onNext: { [weak self] in
//                self?.toggleTorch()
//            }).disposed(by: disposeBag)
//
//        rootView.bottomControlBar.switchCameraButton
//            .rx.tap
//            .asDriver()
//            .debug("switchCameraButton")
//            .drive(onNext: { [weak self] in
//                self?.switchCam()
//            }).disposed(by: disposeBag)
//
//        rootView.bottomControlBar.lockOrientationButton
//            .rx.tap
//            .asDriver()
//            .debug("lockOrientationButton")
//            .drive(onNext: { [weak self] in
//                self?.lockOrientation()
//            }).disposed(by: disposeBag)
//
//        rootView.bottomControlBar.pauseButton
//            .rx.tap
//            .asDriver()
//            .debug("pauseButton")
//            .drive(onNext: { [weak self] in
//                self?.pause()
//            }).disposed(by: disposeBag)
//    }
//}
