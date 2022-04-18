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
