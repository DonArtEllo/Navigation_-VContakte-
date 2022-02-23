//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Артем on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol ControllerFactory {
    func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController)
    
    func makeFunnyPicture() -> (viewModel: FunnyPictureModel, controller: FunnyPictureViewController)
    
    func makeNFTCollection() -> (viewModel: NFTCollectionModel, controller: NFTCollectionViewController)
    
    func makeMedia() -> (viewModel: MediaModel, controller: MediaViewController)
}

struct ControllerFactoryImpl: ControllerFactory {
    func makeFunnyPicture() -> (viewModel: FunnyPictureModel, controller: FunnyPictureViewController) {
        let viewModel = FunnyPictureModel()
        let controller = FunnyPictureViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
    func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController) {
        let viewModel = FeedModel()
        let controller = FeedViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
    func makeNFTCollection() -> (viewModel: NFTCollectionModel, controller: NFTCollectionViewController) {
        let viewModel = NFTCollectionModel()
        let controller = NFTCollectionViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
    func makeMedia() -> (viewModel: MediaModel, controller: MediaViewController) {
        let viewModel = MediaModel()
        let controller = MediaViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
}
