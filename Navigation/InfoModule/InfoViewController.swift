//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    private var viewModel: InfoViewOutput
    
    private let todosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(viewModel: InfoViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        changeLabelFromJSON()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.white

        view.addSubview(todosLabel)
        
        let constraints = [
            todosLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            todosLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            todosLabel.heightAnchor.constraint(equalToConstant: 150),
            todosLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func changeLabelFromJSON() {
        // MARK: - 1.4
        viewModel.getLabelTextFromJSONSerialization { [weak self] (str) in
            DispatchQueue.main.async {
                self?.todosLabel.text = str
            }
        }
    }
}
