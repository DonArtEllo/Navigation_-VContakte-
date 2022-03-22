//
//  MediaCoordinator.swift
//  Navigation
//
//  Created by Артем on 23.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class MediaCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    private let factory: ControllerFactory
    private lazy var mediaModule = {
        factory.makeMedia()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        navigationController.pushViewController(self.mediaModule.controller, animated: true)

        mediaModule.viewModel.onShowVoiceRecorder = {
            
            let voiceRecorderCoordinator = VoiceRecorderCoordinator(navigation: self.navigationController, factory: self.factory)
            voiceRecorderCoordinator.start()
        }

        mediaModule.viewModel.onShowFeed = {
            self.navigationController.popToRootViewController(animated: true)
        }
    }

}
