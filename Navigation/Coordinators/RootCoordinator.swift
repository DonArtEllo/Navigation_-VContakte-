//
//  ViewsCoordinator.swift
//  Navigation
//
//  Created by Артем on 11.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
// MARK: - 1-1.
class RootCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let tabBarController: TabBarController
    private let factory = ControllerFactoryImpl()
    
    // MARK: - 1-2.
    init() {
        tabBarController = TabBarController()
        
        let feedCoordinator = configureFeed()
        coordinators.append(feedCoordinator)
        let funnyPictureCoordinator = configureFunnyPicture()
        coordinators.append(funnyPictureCoordinator)
        let loginCoordinator = configureLogin()
        coordinators.append(loginCoordinator)

        tabBarController.viewControllers = [feedCoordinator.navigationController,
                                            loginCoordinator.navigationController
        ]
        
        feedCoordinator.start()
        funnyPictureCoordinator.start()
        loginCoordinator.start()
    }
    
    private func configureFeed() -> FeedCoordinator {
        
        let navigationFirst = UINavigationController()
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "square.and.pencil"),
            selectedImage: nil)
        let coordinator = FeedCoordinator(
            navigation: navigationFirst,
            factory: factory)
        
        return coordinator
    }
    
    private func configureFunnyPicture() -> FunnyPictureCoordinator {
        
        let navigationFP = UINavigationController()
        
        let coordinator = FunnyPictureCoordinator(
            navigation: navigationFP,
            factory: factory)
        
        return coordinator
    }
    
    private func configureLogin() -> LoginCoordinator {
        
        let navigationSecond = UINavigationController()
        navigationSecond.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: nil)
        let coordinator = LoginCoordinator(
            navigation: navigationSecond)
        
        return coordinator
    }
//    private func configureLogin() -> LoginCoordinator {
//
//        let navigationFirst = UINavigationController()
//        navigationFirst.tabBarItem = UITabBarItem(
//            title: "Profile",
//            image: UIImage(systemName: "person"),
//            selectedImage: nil)
//        let coordinator = LoginCoordinator(
//            navigation: navigationFirst, factory: factory)
//
//        return coordinator
//    }
}

