//
//  Passworder.swift
//  Navigation
//
//  Created by Артем on 28.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

// Слой бизнес-логики или МОДЕЛЬ

final class FeedModel {
        
    let notificationCenter = NotificationCenter.default
    private let secretWord: String = "Conditional password"
    
    init() {}
    
    func check(word: String) {
        
        var notification = Notification(
            name: NSNotification.Name(rawValue: "Clear notification"),
            object: nil,
            userInfo: nil)
        
        if word == secretWord {
            notification.name = NSNotification.Name(rawValue: "Word is correct")
        } else {
            notification.name = NSNotification.Name(rawValue: "Word is not correct")
        }
        
        notificationCenter.post(notification)
    }
}
