//
//  TestUserService.swift
//  Navigation
//
//  Created by Артем on 12.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

// Mark: - 6.
class TestUserService: UserService {
    
    let testUser = User(userName: "Test User", userAvatar: #imageLiteral(resourceName: "test_avatar"))
    
    func currentUser(userName: String) -> User {
        
        return testUser
    }
    
}
