//
//  CustomButton.swift
//  Navigation
//
//  Created by Артем on 28.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

// MARK: - 1-1.
final class UpgradedButton: UIButton {
    
    var nextLevelUltraNewAction: (() -> Void)?
    
    init(
        titleText title: String,
        titleColor color: UIColor,
        backgroundColor bgColor: UIColor,
        tapAction: (() -> Void)?
    ) {
        self.nextLevelUltraNewAction = tapAction
        
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = bgColor
        
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(upgradedTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func upgradedTap() {
        nextLevelUltraNewAction?()
    }
}
