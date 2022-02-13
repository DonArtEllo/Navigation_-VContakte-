//
//  TestUserService.swift
//  Navigation
//
//  Created by Артем on 12.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class TestUserService: UserService {
    
    let testUser = User(userLogin: "TEST", userName: "Test User", userAvatar: #imageLiteral(resourceName: "test_avatar"))
    
    func currentUser(userLogin: String) throws -> User {
        
        return testUser
    }
    
}
