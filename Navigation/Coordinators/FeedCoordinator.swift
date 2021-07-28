//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Артем on 22.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        
        let viewController = FeedViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
