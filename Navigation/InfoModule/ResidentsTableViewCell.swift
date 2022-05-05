//
//  ResidentsTableViewCell.swift
//  Navigation
//
//  Created by Артем on 05.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class ResidentsTableViewCell: UITableViewCell {
    
    var resident: String? {
        didSet {
            self.nameLabel.text = resident
        }
    }
    var representedIdentifier = 0
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.text = ""
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
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
        
        contentView.addSubview(nameLabel)
        
        // MARK: Constraints
        let constraints = [
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
