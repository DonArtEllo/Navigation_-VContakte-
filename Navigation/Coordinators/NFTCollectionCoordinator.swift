//
//  NFTCollectionCoordinator.swift
//  Navigation
//
//  Created by Артем on 26.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class NFTCollectionCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    private let factory: ControllerFactory
    private lazy var nFTCollectionModule = {
        factory.makeNFTCollection()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        navigationController.pushViewController(self.nFTCollectionModule.controller, animated: true)


        nFTCollectionModule.viewModel.onShowFeed = {
            self.navigationController.popToRootViewController(animated: true)
        }
    }

}
