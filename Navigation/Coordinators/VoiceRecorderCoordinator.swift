//
//  VoiceRecorderCoordinator.swift
//  Navigation
//
//  Created by Артем on 23.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

final class VoiceRecorderCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    private let factory: ControllerFactory
    private lazy var voiceRecorderModule = {
        factory.makeVoiceRecorder()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        navigationController.pushViewController(self.voiceRecorderModule.controller, animated: true)

        voiceRecorderModule.viewModel.onShowMedia = {
            self.navigationController.popViewController(animated: true)
        }
    }

}
