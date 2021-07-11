//
//  UpgradedTextField.swift
//  Navigation
//
//  Created by Артем on 28.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class UpgradedTextField: UITextField {
    
    var ultraMegaNewText: ((String) -> Void)?
    
    init(
        placeholder emptyText: String,
        onText: ((String) -> Void)?
    ) {
        self.ultraMegaNewText = onText
        
        super.init(frame: .zero)
        
        placeholder = emptyText
        
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(textPrinted), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
    }
    
    @objc private func textPrinted() {
        guard let text = text, !text.isEmpty else { return }
        ultraMegaNewText?(text)
    }
}
