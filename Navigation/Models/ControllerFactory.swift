//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Артем on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

// MARK: - 2-1.
protocol ControllerFactory {
    func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController)
    
    func makeFunnyPicture() -> (viewmodel: FunnyPictureModel, controller: FunnyPictureViewController)
    
}

struct ControllerFactoryImpl: ControllerFactory {
    // MARK: - 2-2.
    func makeFunnyPicture() -> (viewmodel: FunnyPictureModel, controller: FunnyPictureViewController) {
        let viewModel = FunnyPictureModel()
        let controller = FunnyPictureViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
    func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController) {
        let viewModel = FeedModel()
        let controller = FeedViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
}
