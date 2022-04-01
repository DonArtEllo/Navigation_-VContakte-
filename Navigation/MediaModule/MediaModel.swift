//
//  MediaModel.swift
//  Navigation
//
//  Created by Артем on 23.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

protocol MediaViewOutput {
    var songsURLs : [String] { get }
    var videosURLs : [String] { get }
    var onTapGoBackToFeed: () -> Void { get }
    var onTapShowVoiceRecorder: () -> Void { get }
}

final class MediaModel: MediaViewOutput {
    
    // MARK: - 1-4 Songs for player
    let songsURLs : [String] = [
        "Queen",
        "BURN",
        "IAmDead",
        "LoFiChillHop",
        "MorningDay",
        "SaveMe"
    ]
    
    // MARK: - 1-5 Videos for table
    let videosURLs : [String] = [
        Bundle.main.path(forResource: "Jake", ofType: "mp4")!,
        Bundle.main.path(forResource: "PHXNKPLAYA", ofType: "mp4")!,
        Bundle.main.path(forResource: "Smart", ofType: "mp4")!,
        Bundle.main.path(forResource: "JakeOHM", ofType: "mp4")!
    ]
        
    var onShowFeed: (() -> Void)?
    
    lazy var onTapGoBackToFeed: () -> Void = { [weak self] in
        self?.onShowFeed?()
    }
    
    var onShowVoiceRecorder: (() -> Void)?
    
    lazy var onTapShowVoiceRecorder: () -> Void = { [weak self] in
        self?.onShowVoiceRecorder?()
    }
}

