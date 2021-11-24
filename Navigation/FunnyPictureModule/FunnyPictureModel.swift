//
//  FunnyPictureModel.swift
//  Navigation
//
//  Created by Артем on 18.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

// MARK: - 2-5.
protocol FunnyPictureViewOutput {
    var moduleTitle: String { get }
    var onTapGoBackToFeed: () -> Void { get }
}

final class FunnyPictureModel: FunnyPictureViewOutput {
    
    var moduleTitle: String {
        return "SMILE :)"
    }
    
    var onShowFeed: (() -> Void)?
    
    lazy var onTapGoBackToFeed: () -> Void = { [weak self] in
        self?.onShowFeed?()
    }
}
