//
//  VideosTableViewCell.swift
//  Navigation
//
//  Created by Артем on 23.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class VideosTableViewCell: UITableViewCell {
    
    var representedIdentifier = 0
    
    private let videoLabel: UILabel = {
        let videoLabel = UILabel()
        videoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        videoLabel.textColor = .black
        videoLabel.text = "Play video"
        
        videoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return videoLabel
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    // MARK: - Setup Views
    fileprivate func setupViews() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(videoLabel)
        
        
        //MARK: Constraints
        let constraints = [
            
            videoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            videoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
