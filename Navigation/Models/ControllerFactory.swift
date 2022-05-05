//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Артем on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol ControllerFactory {
    func makeInfo() -> (viewModel: InfoModel, controller: InfoViewController)
    
    func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController)
    
    func makeFunnyPicture() -> (viewModel: FunnyPictureModel, controller: FunnyPictureViewController)
    
    func makeNFTCollection() -> (viewModel: NFTCollectionModel, controller: NFTCollectionViewController)
    
    func makeMedia() -> (viewModel: MediaModel, controller: MediaViewController)
    
    func makeVoiceRecorder() -> (viewModel: VoiceRecorderModel, controller: VoiceRecorderViewController)
}

struct ControllerFactoryImpl: ControllerFactory {
    func makeInfo() -> (viewModel: InfoModel, controller: InfoViewController) {
        let viewModel = InfoModel()
        let controller = InfoViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
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
    
    func makeVoiceRecorder() -> (viewModel: VoiceRecorderModel, controller: VoiceRecorderViewController) {
        let viewModel = VoiceRecorderModel()
        let controller = VoiceRecorderViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
}
