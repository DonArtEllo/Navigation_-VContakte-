//
//  FunnyPictureViewController.swift
//  Navigation
//
//  Created by Артем on 18.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

final class FunnyPictureViewController: UIViewController{
    
    private var viewModel: FunnyPictureViewOutput
    private let dogeImagesArray = [
        #imageLiteral(resourceName: "doge"),
        #imageLiteral(resourceName: "doge_2"),
        #imageLiteral(resourceName: "doge_3"),
        #imageLiteral(resourceName: "doge_4"),
        #imageLiteral(resourceName: "doge_5")
    ]
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dogeImageView: UIImageView = {
        let doge = UIImageView()
        doge.image = #imageLiteral(resourceName: "doge_5")
        doge.contentMode = .scaleAspectFit
        
        doge.translatesAutoresizingMaskIntoConstraints = false
        return doge
    }()
    
    private lazy var iAmGoodButton: UpgradedButton = {
        let button = UpgradedButton(titleText: "Thx I'm not sad any more :)", titleColor: .black, backgroundColor: .white, tapAction: actionGoBackToFeedButtonPressed)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: FunnyPictureViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addTimer()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .yellow
        
        view.addSubviews(
            timerLabel,
            dogeImageView,
            iAmGoodButton
        )
        
        let constraints = [
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dogeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            dogeImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -150),
            
            iAmGoodButton.centerXAnchor.constraint(equalTo: dogeImageView.centerXAnchor),
            iAmGoodButton.centerYAnchor.constraint(equalTo: dogeImageView.bottomAnchor, constant: 37.5),
            iAmGoodButton.widthAnchor.constraint(equalToConstant: 250),
            iAmGoodButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func actionGoBackToFeedButtonPressed() {
        viewModel.onTapGoBackToFeed()
    }
    
    private func addTimer() {
        var imageNumber = 0
        var sec = -1
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            sec += 1
            if sec == 5 {
                self.timerLabel.text = "New image!"
            } else {
                self.timerLabel.text = "New image in \(5 - sec)..."
            }
            
            if sec == 5 {
                self.changeDogeImage(imageNumber: imageNumber)
                imageNumber += 1
                
                if imageNumber > 4 {
                    imageNumber = 0
                }
                sec = -1
            }
            
            if self.view.isHidden {
                timer.invalidate()
            }
        }
        
        timer.fire()
        
        
    }
    
    private func changeDogeImage(imageNumber: Int) {
        self.dogeImageView.image = self.dogeImagesArray[imageNumber]
    }
}
