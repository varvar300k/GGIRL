//
//  SettingsTableView.swift
//  GGIRL
//
//  Created by VARVAR on 30.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    private var viewModel: SettingsViewModel!
    
    func injectViewModel(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private struct Section {
        let type: SectionType
        let rows: [RowType]
    }
    
    private enum SectionType: String {
        case broadcast = "Трансляция"
        case audio = "Аудио"
        case chat = "Чат"
        case user = "Пользователь"
    }
    
    private enum RowType {
        case resolution
        case stabilization
        case framerate
        case bitrate
        case samplerate
        case speech
        case logout
        var title: String {
            switch self {
            case .resolution:
                return "Разрешение"
            case .stabilization:
                return "Стабилизация"
            case .framerate:
                return "Количество кадров"
            case .bitrate:
                return "Битрейт"
            case .samplerate:
                return "Частота"
            case .speech:
                return "Озвучивание"
            case .logout:
                return "Выход"
            }
        }
        var description: String {
            switch self {
            case .resolution:
                return "Разрешение - описание"
            case .stabilization:
                return "Стабилизация - описание"
            case .framerate:
                return "Количество кадров - описание"
            case .bitrate:
                return "Битрейт - описание"
            case .samplerate:
                return "Частота - описание"
            case .speech:
                return "Озвучивание - описание"
            case .logout:
                return "Выход - описание"
            }
        }
    }
    
    private let sections = [Section(type: .broadcast, rows: [.resolution, .stabilization, .framerate, .bitrate]),
                            Section(type: .audio, rows: [.samplerate]),
                            Section(type: .chat, rows: [.speech]),
                            Section(type: .user, rows: [.logout])]
    
    private let cellId = "SettingsCell"
    
    override func viewDidLoad() {
        setupView()
    }
    
    lazy var navBar: UINavigationBar = {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        navBar.isTranslucent = false
        navBar.tintColor = .white
        navBar.barTintColor = .darkGrey
        navBar.height(44)
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let navItem = UINavigationItem(title: "Настройки")
        let backItem = UIBarButtonItem(image: UIImage(named: "back_arrow_button"), style: .plain, target: self, action: #selector(closeSettingsButtonAction))
        backItem.tintColor = .white
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = nil
        tableView.backgroundColor = .bgBlack
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.backgroundView = nil
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    
    func setupView() {
        self.view.backgroundColor = UIColor.darkGrey
        self.view.addSubview(navBar)
        navBar.edgesToSuperview(excluding: .bottom, usingSafeArea: false)
        self.view.addSubview(settingsTableView)
        settingsTableView.edgesToSuperview(excluding: .top, usingSafeArea: false)
        settingsTableView.topToBottom(of: navBar)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    @objc func closeSettingsButtonAction() {
        viewModel.inputs.tapClose.onNext(())
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        let attributedText = NSMutableAttributedString(string: row.title,
                                                       attributes: [.foregroundColor: UIColor.white,
                                                                    .paragraphStyle: NSMutableParagraphStyle(),
                                                                    .font: UIFont.systemFont(ofSize: 16)])
        let attributedDescriptionText = NSMutableAttributedString(string: row.description,
                                                                  attributes: [.foregroundColor: UIColor.white,
                                                                               .paragraphStyle: NSMutableParagraphStyle(),
                                                                               .font: UIFont.systemFont(ofSize: 12)])
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.attributedText = attributedText
        cell.detailTextLabel?.attributedText = attributedDescriptionText
        cell.contentView.backgroundColor = .darkGrey
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].type.rawValue
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        let row = sections[indexPath.section].rows[indexPath.row]
        if row == .logout {
            viewModel.inputs.tapLogOut.onNext(())
        } else if let alert = makeAlertViewController(for: row) {
            alert.modalTransitionStyle = .crossDissolve
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension SettingsViewController {
    private func makeAlertViewController(for type: RowType) -> UIViewController? {
        switch type {
        case .resolution:
            return ResolutionSettingAlertViewController(title: type.title, rows: [VideoSettings.Resolution.nHD.rawValue,
                                                                                  VideoSettings.Resolution.HD.rawValue,
                                                                                  VideoSettings.Resolution.FHD.rawValue])
        case .stabilization:
            return StabilizationSettingAlertViewController(title: type.title, rows: [AVCaptureVideoStabilizationMode.off.description,
                                                                                  AVCaptureVideoStabilizationMode.standard.description,
                                                                                  AVCaptureVideoStabilizationMode.cinematic.description,
                                                                                  AVCaptureVideoStabilizationMode.auto.description])
        case .framerate:
            return FramerateSettingAlertViewController(title: type.title, rows: ["24", "30", "60"])
        case .bitrate:
            return BitrateSettingAlertViewController(title: type.title, rows: ["500", "700", "1000", "1500", "2000", "2500", "3000", "3500","4000", "4500", "5000", "5500", "6000", "8000", "10000", "13000", "16000", "24000", "32000", "40000", "48000"])
        case .samplerate:
            return SamplerateSettingAlertViewController(title: type.title, rows: [AudioSettings.Audiorate.low.rawValue,
                                                                                AudioSettings.Audiorate.medium.rawValue,
                                                                                AudioSettings.Audiorate.high.rawValue,
                                                                                AudioSettings.Audiorate.vhigh.rawValue])
        case .speech:
            return SpeechSettingAlertViewController(title: type.title, rows: [ChatSettings.Speech.none.rawValue,
                                                                            ChatSettings.Speech.donat.rawValue,
                                                                            ChatSettings.Speech.all.rawValue])
        default:
            return nil
        }
    }
}
