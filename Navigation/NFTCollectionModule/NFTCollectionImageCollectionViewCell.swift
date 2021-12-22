//
//  NFTCollectionImageCollectionViewCell.swift
//  Navigation
//
//  Created by Артем on 26.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

class NFTCollectionImageCollectionViewCell: UICollectionViewCell {
    
    var representedIdentifier = 0
    
    private let imageContentImageView: UIImageView = {
        let imageContentImageView = UIImageView()
        imageContentImageView.contentMode = .scaleAspectFit
        imageContentImageView.backgroundColor = .systemGray4
                
        return imageContentImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageContentImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageContentImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: self.bounds.height
        )
        
    }
    
    func configure(with image: UIImage) {
        imageContentImageView.image = image
    }
}