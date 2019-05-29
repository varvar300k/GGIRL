//
//  ResolutionAlert.swift
//  GGIRL
//
//  Created by VARVAR on 03.05.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit
import RxSwift
import RxCocoa

class SettingsAlertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rows = [String]()
    let cellId = "ParameterCell"
    
    lazy var settingTitle: UILabel = {
        let label = UILabel()
        label.contentMode = .center
        label.textColor = .white
        return label
    }()
    
    lazy var settingParameters: UITableView = {
        let table = UITableView(frame: .zero)
        table.backgroundColor = UIColor.clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 44
        table.separatorStyle = .singleLine
        table.separatorColor = .white
        table.separatorInset = .zero
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView(frame: .zero)
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ParameterCell")
        table.allowsSelection = true
        table.allowsMultipleSelection = false
        table.alwaysBounceVertical = false
        return table
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.contentMode = .center
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        return button
    }()
    
    func setupView() {
        view.backgroundColor = .bgBlackTr
        
        let topBreakLine = UIView(frame: .zero)
        topBreakLine.height(1)
        topBreakLine.backgroundColor = .white
        let bottomBreakLine = UIView(frame: .zero)
        bottomBreakLine.height(1)
        bottomBreakLine.backgroundColor = .white
        
        let size = rows.count > 4 ? 258 : (rows.count*44+82)
        let alertView = UIView(frame: CGRect(x: 60, y: 60, width: 200, height: size))
        alertView.backgroundColor = .navBarBlue
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 15
        view.addSubview(alertView)
        alertView.width(250)
        alertView.height(CGFloat(size))
        alertView.centerXToSuperview()
        alertView.centerYToSuperview()
        
        alertView.addSubview(settingTitle)
        alertView.addSubview(topBreakLine)
        alertView.addSubview(settingParameters)
        alertView.addSubview(bottomBreakLine)
        alertView.addSubview(cancelButton)
        
        settingTitle.topToSuperview()
        settingTitle.centerXToSuperview()
        settingTitle.height(40)
        
        topBreakLine.leadingToSuperview()
        topBreakLine.trailingToSuperview()
        topBreakLine.topToBottom(of: settingTitle)
        
        cancelButton.edgesToSuperview(excluding: .top)
        cancelButton.height(40)
        
        bottomBreakLine.leadingToSuperview()
        bottomBreakLine.trailingToSuperview()
        bottomBreakLine.bottomToTop(of: cancelButton)
        
        settingParameters.topToBottom(of: topBreakLine)
        settingParameters.leadingToSuperview()
        settingParameters.trailingToSuperview()
        settingParameters.bottomToTop(of: bottomBreakLine)
        
        settingParameters.delegate = self
        settingParameters.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingParameters.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let attributedText = NSMutableAttributedString(string: rows[indexPath.row],
                                                       attributes: [.foregroundColor: UIColor.white,
                                                                    .paragraphStyle: NSMutableParagraphStyle(),
                                                                    .font: UIFont.systemFont(ofSize: 14)])
        cell.textLabel?.attributedText = attributedText
        cell.contentView.backgroundColor = .navBarBlue
        cell.backgroundColor = .navBarBlue
        cell.tintColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let path = settingParameters.indexPathForSelectedRow
        if path == indexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    override func viewDidLoad() {
        setupView()
        setupTable()
    }
    
    func setupTable() {}
    
    @objc func cancelButtonAction(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    public init(title: String, rows: [String]) {
        self.rows = rows
        super.init(nibName: nil, bundle: nil)
        self.settingTitle.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ResolutionSettingAlertViewController: SettingsAlertViewController {
    
    override func setupTable() {
        let currentResolution = Preference.shared.video.resolution.rawValue
        settingParameters.selectRow(at: IndexPath(row: rows.firstIndex(of: currentResolution) ?? 0, section: 0), animated: false, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newResolution = VideoSettings.Resolution(rawValue: rows[indexPath.row]) {
            Preference.shared.video.resolution = newResolution
            if let cell = settingParameters.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }
    }
    
}

class StabilizationSettingAlertViewController: SettingsAlertViewController {
    
    override func setupTable() {
        let currentStabilization = Preference.shared.video.stabilization == -1 ? 3 : Preference.shared.video.stabilization
        settingParameters.selectRow(at: IndexPath(row: currentStabilization, section: 0), animated: false, scrollPosition: .none)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 2 {
            Preference.shared.video.stabilization = AVCaptureVideoStabilizationMode.auto.rawValue
        } else {
            Preference.shared.video.stabilization = indexPath.row
        }
        if let cell = settingParameters.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
}

class FramerateSettingAlertViewController: SettingsAlertViewController {
    
    override func setupTable() {
        let currentFps = String(Preference.shared.video.fps)
        settingParameters.selectRow(at: IndexPath(row: rows.firstIndex(of: currentFps) ?? 0, section: 0), animated: false, scrollPosition: .none)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newFps = Int(rows[indexPath.row]) {
            Preference.shared.video.fps = newFps
            if let cell = settingParameters.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }
    }
    
}

class BitrateSettingAlertViewController: SettingsAlertViewController {
    
    override func setupTable() {
        let currentBitrate = String(Preference.shared.video.bitrate/1024)
        settingParameters.selectRow(at: IndexPath(row: rows.firstIndex(of: currentBitrate) ?? 2, section: 0), animated: false, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newBitrate = Int(rows[indexPath.row]) {
            Preference.shared.video.bitrate = newBitrate*1024
            if let cell = settingParameters.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }
    }
    
}

class SamplerateSettingAlertViewController: SettingsAlertViewController {
    
    override func setupTable() {
        let currentSamplerate = Preference.shared.audio.rate.rawValue
        settingParameters.selectRow(at: IndexPath(row: rows.firstIndex(of: currentSamplerate) ?? 0, section: 0), animated: false, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newAudiorate = AudioSettings.Audiorate(rawValue: rows[indexPath.row]) {
            Preference.shared.audio.rate = newAudiorate
            if let cell = settingParameters.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }
    }
    
}

class SpeechSettingAlertViewController: SettingsAlertViewController {
    
    override func setupTable() {
        let currentSpeech = Preference.shared.chat.speech.rawValue
        settingParameters.selectRow(at: IndexPath(row: rows.firstIndex(of: currentSpeech) ?? 0, section: 0), animated: false, scrollPosition: .none)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newSpeech = ChatSettings.Speech(rawValue: rows[indexPath.row]) {
            Preference.shared.chat.speech = newSpeech
            if let cell = settingParameters.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }
    }
    
}
