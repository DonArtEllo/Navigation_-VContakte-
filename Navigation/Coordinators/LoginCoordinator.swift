//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Артем on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class LoginCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    let loginFactory = MyLogInFactory()
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        
        let viewController = LogInController()
        viewController.coordinator = self
        viewController.delegate = loginFactory.setLogInInspector()
        navigationController.pushViewController(viewController, animated: true)
    }
}

//final class LoginCoordinator: Coordinator {
//    var coordinators: [Coordinator] = []
//    let navigationController: UINavigationController
//
//    private let factory: ControllerFactory
//    private lazy var loginModule = {
//        factory.makeLogIn()
//    }()
//    private var loginModel: LogInViewOutput
//
//    init(navigation: UINavigationController, factory: ControllerFactory) {
//        self.navigationController = navigation
//        self.factory = factory
//    }
//
//    func start() {
//
//        loginModule.viewModel.onShowProfile = { [weak self] in
//            guard let controller = self?.configureProfile(<#UserService#>, <#String#>) else { return }
//            self?.navigationController.pushViewController(controller, animated: true)
//
//        }
//
//        navigationController.pushViewController(loginModule.controller, animated: true)
//    }
//    
//    private func configureProfile(_ userService: UserService, _ typedLogin: String) -> ProfileViewController {
//        return factory.makeProfile(userService: userService, typedLogin: typedLogin)
//    }
//}
