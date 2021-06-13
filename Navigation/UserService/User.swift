//
//  UserData.swift
//  Navigation
//
//  Created by Артем on 12.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

// MARK: - 2.
protocol UserService {
    
    func currentUser(userName: String) -> User
}

// MARK: - 1.
class User {
    
    internal let userName: String
    internal var userAvatar: UIImage
    
    init(userName: String,
         userAvatar: UIImage) {
        
        self.userName = userName
        self.userAvatar = userAvatar
    }
}
