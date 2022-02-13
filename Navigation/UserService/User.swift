//
//  UserData.swift
//  Navigation
//
//  Created by Артем on 12.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol UserService {
    
    func currentUser(userLogin: String) throws -> User
}

class User {
    
    internal let userLogin: String
    internal let userName: String
    internal var userAvatar: UIImage
    
    init(userLogin: String,
         userName: String,
         userAvatar: UIImage) {
        
        self.userLogin = userLogin
        self.userName = userName
        self.userAvatar = userAvatar
    }
}
