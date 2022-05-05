//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Артем on 05.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class InfoCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    private let factory: ControllerFactory
    private lazy var infoModule = {
        factory.makeInfo()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        
        navigationController.pushViewController(infoModule.controller, animated: true)
    }
}
