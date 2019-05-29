//
//  ChatUtils.swift
//  GGIRL
//
//  Created by VARVAR on 12.03.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import Domain

struct ChatUtils {
    public static let shared = ChatUtils()
    var user = UserUtils()
    var message = MessageUtils()
    var smile = SmileUtils()
    private init() {}
}

struct UserUtils {
    init() {}
    
    var icon = { (name: String?) -> FontIcon? in
        switch name {
        case "phone":
            return FontIcon.phone
        case "ios":
            return FontIcon.ios
        case "win":
            return FontIcon.win
        case "android":
            return FontIcon.android
        case "staff":
            return FontIcon.staff
        case "coin":
            return FontIcon.ruble
        case "eagle":
            return FontIcon.eagle
        case "cup":
            return FontIcon.cup
        case "diamond":
            return FontIcon.diamond
        case "crown":
            return FontIcon.crown
        case "undead":
            return FontIcon.undead
        case "top1":
            return FontIcon.top1
        case "helper":
            return FontIcon.helper
        case "moderator":
            return FontIcon.moderator
        case "star":
            return FontIcon.starOne
        default:
            return nil
        }
    }
    var color = { (name: String?) -> UIColor in
        switch name {
        case "simple":
            return UIColor.chatBlue
        case "premium":
            return UIColor.chatGGPlus
        case "premium-personal":
            return UIColor.chatGreen
        case "diamond":
            return UIColor.chatDimond
        case "bronze":
            return UIColor.chatOrange
        case "silver":
            return UIColor.chatSilver
        case "gold":
            return UIColor.chatGold
        case "king":
            return UIColor.chatKing
        case "undead":
            return UIColor.undead
        case "streamer":
            return UIColor.chatYellow
        case "top-one":
            return UIColor.chatHero
        case "moderator":
            return UIColor.chatRed
        default:
            return UIColor.chatBlue
        }
    }
}

struct MessageUtils {
    init() {}
    
    var color = { (msg: ChatMessageType) -> UIColor in
        switch msg {
        case is UserMessage:
            return (msg as! UserMessage).isForMe ? UIColor.chatGold : UIColor.white
        case is DonatMessage:
            return UIColor.chatKing
        case is PremiumMessage:
            return UIColor.green
        case is BanMessage:
            return UIColor.red
        case is SystemMessage:
            return UIColor.orange
        default:
            return UIColor.white
        }
    }
    
    func makeAttrMessage(message: ChatMessageType) -> NSAttributedString {
        switch message {
        case is UserMessage:
            return createUserText(message: message as! UserMessage)
        default:
            return createGenericText(message: message)
        }
    }
    
    private func createUserText(message: UserMessage) -> NSAttributedString {
        let attrMessage = NSMutableAttributedString()
        let userColor = ChatUtils.shared.user.color(message.user.color)
        let userText = NSMutableAttributedString(string: message.user.name + ": ",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                              .foregroundColor: userColor])
        if let icon = ChatUtils.shared.user.icon(message.user.icon) {
            let iconText = NSMutableAttributedString(string: icon.rawValue,
                                                     attributes: [.font: UIFont(name: "icomoon", size: 12.0)!,
                                                                  .foregroundColor: userColor])
            attrMessage.append(iconText)
        }
        
        let messageText = NSMutableAttributedString(string: message.text,
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                              .foregroundColor: message.isForMe ? UIColor.chatYellow : .white])
        attrMessage.append(userText)
        attrMessage.append(messageText)
        return attrMessage
    }
    
    private func createGenericText(message: ChatMessageType) -> NSAttributedString {
        return NSAttributedString(string: message.text, attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: ChatUtils.shared.message.color(message) ])
    }
    
    public static func speechMessage(_ text: String) {
        var speechSynthesizer = AVSpeechSynthesizer()
        var speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        //TODO: CHECK TEXT LANGUAGE
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        speechSynthesizer.speak(speechUtterance)
    }
}

struct SmileUtils {
    init() {}
}
