//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Apple on 24.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import SnapKit

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String = "Searching for your IP..."
    
    // MARK: - Profile Header Content
    // User's profile image
    internal var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
            
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        return avatarImageView
    }()
    
    // User's profile name
    internal let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black
        
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

        return fullNameLabel
    }()
    
    // User's profile status
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Searching for your IP..."
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .gray
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        return statusLabel
    }()
    
    // User's status editing field
    private let statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.backgroundColor = .white
        statusTextField.placeholder = "Enter new status"
        statusTextField.font = UIFont.systemFont(ofSize: 15)
        statusTextField.textColor = .black
        statusTextField.leftView = UIView(frame:
                                            CGRect(
                                                x: 0,
                                                y: 0,
                                                width: 10,
                                                height: 40
                                            )
        )
        statusTextField.leftViewMode = .always
            
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        
        statusTextField.addTarget(self, action: #selector(statusTextFieldChanged), for: .editingDidEnd)
        
        statusTextField.translatesAutoresizingMaskIntoConstraints = false

        return statusTextField
    }()
    
    // Status button
    private let setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.setTitle("Show status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.backgroundColor = .systemBlue
            
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        
        setStatusButton.addTarget(self, action: #selector(actionSetStatusButtonPressed), for: .touchUpInside)
        
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false

        return setStatusButton
    }()
    
    // MARK: Actions
    @objc private func actionSetStatusButtonPressed() {
        statusTextField.endEditing(true)
        if statusText == "" {
            statusText = "No status"
        }
        statusLabel.text = statusText
        statusTextField.text = ""
        print(statusLabel.text ?? "No status")
    }
    
    @objc private func statusTextFieldChanged() {
        statusText = statusTextField.text ?? "No status"
    }
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    // MARK:Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = contentView.bounds.width * 0.3 / 2

    }
    
    // MARK: - SetupViews
    fileprivate func setupViews() {
        
        #if DEBUG
        contentView.backgroundColor = .systemYellow
        #else
        contentView.backgroundColor = .systemGray6
        #endif
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        contentView.addSubview(setStatusButton)
        
        fullNameLabel.sizeToFit()
        statusLabel.sizeToFit()
        
        // MARK: Constraints
        avatarImageView.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.3)
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16).priority(750)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(avatarImageView).offset(-18)
            make.leading.equalTo(fullNameLabel)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.leading.equalTo(statusLabel)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.width.equalTo(contentView).offset(-32).priority(750)
            make.height.equalTo(50)
            make.top.equalTo(avatarImageView.snp.bottom).offset(48)
            make.leading.equalTo(contentView).offset(16)
        }
        
    }

}
