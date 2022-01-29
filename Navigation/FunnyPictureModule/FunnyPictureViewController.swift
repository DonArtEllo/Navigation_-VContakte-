//
//  FunnyPictureViewController.swift
//  Navigation
//
//  Created by Артем on 18.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

// MARK: - 1
/*
 1. Переход из Login на Profile сделать не моментальным, а с задержкой (будто происходит связь с сервером)
 
 2. На странице с весёлой картинкой раз в некоторое время менять изображение (сделать массив картинок и проходить по ним с определённым интервалом)
 
 3. На экране, где загружается коллекция изображений с фильтром:
    - показать таймер с начала обработки
    - по окончанию обработки выводить alert с названием фильтра и временем, затраченным на обработку
    - alert можно просто закрыть или поменять фильтр и начать обработку снова
    - если пользователь выбрал "сменить фильтр", то через 3 секунды начать обработку уже со следующим фильтром из списка
 */

import UIKit

final class FunnyPictureViewController: UIViewController{
    
    private var viewModel: FunnyPictureViewOutput
    
    private let dogeImageView: UIImageView = {
        let doge = UIImageView()
        doge.image = #imageLiteral(resourceName: "doge")
        
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
    }
    
    private func setupViews() {
        navigationController?.navigationBar.isHidden = true
        title = viewModel.moduleTitle
        view.backgroundColor = .yellow
        
        view.addSubviews(
            dogeImageView,
            iAmGoodButton
        )
        
        let constraints = [
            dogeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            dogeImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -100),
            
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
}
