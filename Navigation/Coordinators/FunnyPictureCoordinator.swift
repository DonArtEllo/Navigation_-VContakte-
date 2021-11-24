//
//  FunnyPictureCoordinator.swift
//  Navigation
//
//  Created by Артем on 19.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FunnyPictureCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    private let factory: ControllerFactory
    private lazy var funnyPictureModule = {
        factory.makeFunnyPicture()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    // MARK: - 2-4.
    func start() {
        
        navigationController.pushViewController(funnyPictureModule.controller, animated: true)

        funnyPictureModule.viewmodel.onShowFeed = {
            self.navigationController.popToRootViewController(animated: true)
        }
    }

}
