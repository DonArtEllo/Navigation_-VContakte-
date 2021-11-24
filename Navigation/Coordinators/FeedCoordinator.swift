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
    
    private let factory: ControllerFactory
    private lazy var feedModule = {
        factory.makeFeed()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        
        feedModule.viewModel.onShowFunnyPicture = {
            
            let funnyPictureCoordinator = FunnyPictureCoordinator(navigation: self.navigationController, factory: self.factory)
            funnyPictureCoordinator.start()
        }
        
        feedModule.viewModel.onShowNFTCollection = {
            
            let nFTCollectionCoordinator = NFTCollectionCoordinator(navigation: self.navigationController, factory: self.factory)
            nFTCollectionCoordinator.start()
        }
        
        navigationController.pushViewController(feedModule.controller, animated: true)
    }
}
