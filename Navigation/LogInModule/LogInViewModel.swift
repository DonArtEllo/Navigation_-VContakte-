//
//  LogInViewModel.swift
//  Navigation
//
//  Created by Артем on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

//protocol LogInViewOutput {
//    var onShowProfile: () -> (UserService?, String?) { get }
//    func updateModel(_ userService: UserService, _ typedLogin: String)
//}
//
//// MVVM: часть модуля - ViewModel
//
//class LogInViewModel: LogInViewOutput {
//        
//    private var service: UserService = TestUserService()
//    private var login = ""
//    
//    // интерфейс для отправки данных в координатор
//    lazy var onShowProfile: () -> (UserService?, String?) = { [weak self] in
//        return (self?.service, self?.login)
//    }
//
//    // интерфейс для приема данных от ViewController
//    func checkLoginPassword(stringToCheck: String, time: Date) -> Bool {
//        
//        return Checker.shared.compareHashedStrings(loginPasswordSHA256: stringToCheck, time: time)
//    }
//    
//    // метод трансформирует данные
//    func updateModel(_ userService: UserService, _ typedLogin: String) {
//        self.service = userService
//        self.login = typedLogin
//    }
//}
