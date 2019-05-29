//
//  ChatTable.swift
//  GGIRL
//
//  Created by VARVAR on 18.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ChatTableView: UITableView {
    let disposeBag = DisposeBag()
    
    let datasource = BehaviorRelay<ChatSection>(value: ChatSection(items: []))
    let newMessage = PublishRelay<ChatCellViewModel>()
    
    init() {
        super.init(frame: .zero, style: .plain)
        registerCells()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerCells() {
        self.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatCell")
    }
    
    func configure() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        self.backgroundView = nil
        self.estimatedRowHeight = 60
        self.tableFooterView = UIView(frame: .zero)
        self.rowHeight = UITableView.automaticDimension
        self.allowsSelection = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        let dataSource = ChatTableView.dataSource()
        
        newMessage
            .asDriverOnErrorJustComplete()
            .map { self.appendedItemSection(item: $0) }
            .drive(onNext: { self.datasource.accept($0) })
            .disposed(by: disposeBag)
        
        datasource
            .map { [$0] }
            .asDriverOnErrorJustComplete()
            .drive(rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        datasource
            .map { $0.items.count }
            .asObservable()
            .distinctUntilChanged()
            .subscribe({ [weak self] _ in self?.scrollToBottom() })
            .disposed(by: disposeBag)
    }
    
    private func appendedItemSection(item: ChatCellViewModel) -> ChatSection {
        var section = datasource.value
        let items = section.items + item
        section = ChatSection(original: section, items: items)
        return section
    }
    
    
}

extension ChatTableView {
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<ChatSection> {
        return RxTableViewSectionedAnimatedDataSource(
            animationConfiguration: AnimationConfiguration(insertAnimation: .bottom,
                                                           reloadAnimation: .fade),
            configureCell: { (dataSource, table, idxPath, vmodel) in
                let cell = table.dequeueReusableCell(withIdentifier: "ChatCell", for: idxPath) as! ChatTableViewCell
                cell.bind(vmodel)
                return cell
        },
            titleForHeaderInSection: { (ds, section) -> String? in
                return nil
        },
            canEditRowAtIndexPath: { _, _ in
                return false
        },
            canMoveRowAtIndexPath: { _, _ in
                return false
        }
        )
    }
}
