//
//  ViewsCoordinator.swift
//  Navigation
//
//  Created by Артем on 11.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let tabBarController: TabBarController
    
    init() {
        tabBarController = TabBarController()
        
        let feedCoordinator = configureFeed()
        coordinators.append(feedCoordinator)
        let loginCoordinator = configureLogin()
        coordinators.append(loginCoordinator)

        tabBarController.viewControllers = [feedCoordinator.navigationController, loginCoordinator.navigationController]
        
        feedCoordinator.start()
        loginCoordinator.start()
    }
    
    private func configureFeed() -> FeedCoordinator {
        
        let navigationFirst = UINavigationController()
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "square.and.pencil"),
            selectedImage: nil)
        let coordinator = FeedCoordinator(
            navigation: navigationFirst)
        
        return coordinator
    }
    
    private func configureLogin() -> LoginCoordinator {
        
        let navigationFirst = UINavigationController()
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: nil)
        let coordinator = LoginCoordinator(
            navigation: navigationFirst)
        
        return coordinator
    }
}

extension UIView {
    private func pipiska() {
        print("NYX")
    }
    
}
