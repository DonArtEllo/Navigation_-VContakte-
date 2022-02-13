//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Артем on 12.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class CurrentUserService: UserService {
    
    let currentUser = User(userLogin: "h4ckerK1tten", userName: "Hacker Kitten", userAvatar: #imageLiteral(resourceName: "cat"))

    // MARK: - 3
    func currentUser(userLogin: String) throws -> User {
        
        if userLogin == currentUser.userLogin {
            return currentUser
        } else {
            throw LoginError.serverError
        }
    }
    
}
