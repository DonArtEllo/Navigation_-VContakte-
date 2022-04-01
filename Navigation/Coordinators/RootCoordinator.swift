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
    private let factory = ControllerFactoryImpl()
    
    init() {
        tabBarController = TabBarController()
        
        let feedCoordinator = configureFeed()
        coordinators.append(feedCoordinator)
        let funnyPictureCoordinator = configureFunnyPicture()
        coordinators.append(funnyPictureCoordinator)
        let nFTCollectionCoordinator = configureNFTCollection()
        coordinators.append(nFTCollectionCoordinator)
        let mediaCoordinator = configureMedia()
        coordinators.append(mediaCoordinator)
        let voiceRecorderCoordinator = configureVoiceRecorder()
        coordinators.append(voiceRecorderCoordinator)
        let loginCoordinator = configureLogin()
        coordinators.append(loginCoordinator)

        tabBarController.viewControllers = [feedCoordinator.navigationController,
                                            loginCoordinator.navigationController
        ]
        
        feedCoordinator.start()
        funnyPictureCoordinator.start()
        nFTCollectionCoordinator.start()
        mediaCoordinator.start()
        voiceRecorderCoordinator.start()
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
    
    private func configureNFTCollection() -> NFTCollectionCoordinator {
        
        let navigationNFTC = UINavigationController()
        
        let coordinator = NFTCollectionCoordinator(
            navigation: navigationNFTC,
            factory: factory)
        
        return coordinator
    }
    
    private func configureMedia() -> MediaCoordinator {
        
        let navigationMedia = UINavigationController()
        
        let coordinator = MediaCoordinator(
            navigation: navigationMedia,
            factory: factory)
        
        return coordinator
    }
    
    private func configureVoiceRecorder() -> VoiceRecorderCoordinator {
        
        let navigationVoiceRecorder = UINavigationController()
        
        let coordinator = VoiceRecorderCoordinator(
            navigation: navigationVoiceRecorder,
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
}

