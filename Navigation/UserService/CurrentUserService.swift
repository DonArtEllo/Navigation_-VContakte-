//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Артем on 12.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

// MARK: - 3.
class CurrentUserService: UserService {
    
    let currentUser = User(userName: "Hacker Kitten", userAvatar: #imageLiteral(resourceName: "cat"))

    func currentUser(userName: String) -> User {
        
        if userName == currentUser.userName {
            return currentUser
        } else {
            return User(userName: "", userAvatar: UIImage())
        }
    }
    
}
