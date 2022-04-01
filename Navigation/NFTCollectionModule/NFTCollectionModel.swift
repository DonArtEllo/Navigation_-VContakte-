//
//  NFTCollectionModel.swift
//  Navigation
//
//  Created by Артем on 26.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
//import iOSIntPackage

protocol NFTCollectionViewOutput {
    var nftImages: [UIImage] { get }
    var onTapGoBackToFeed: () -> Void { get }
}

final class NFTCollectionModel: NFTCollectionViewOutput {
    
    // MARK: NFT Images for Collection
    let nftImages = [
        #imageLiteral(resourceName: "punk1"),
        #imageLiteral(resourceName: "punk2"),
        #imageLiteral(resourceName: "punk3"),
        #imageLiteral(resourceName: "punk4"),
        #imageLiteral(resourceName: "punk5"),
        #imageLiteral(resourceName: "bc1"),
        #imageLiteral(resourceName: "bc2"),
        #imageLiteral(resourceName: "bc3"),
        #imageLiteral(resourceName: "bc4"),
        #imageLiteral(resourceName: "bc5"),
        #imageLiteral(resourceName: "mw1"),
        #imageLiteral(resourceName: "mw2"),
        #imageLiteral(resourceName: "mw3"),
        #imageLiteral(resourceName: "mw4"),
        #imageLiteral(resourceName: "mw5")
    ]
        
    var onShowFeed: (() -> Void)?
    
    lazy var onTapGoBackToFeed: () -> Void = { [weak self] in
        self?.onShowFeed?()
    }
}
