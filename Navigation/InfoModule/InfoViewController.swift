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
    
    private let planetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let residentsTableView = UITableView(frame: .zero, style: .grouped)

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
        changeLabelsFromJSON()
        setupTableView()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.white

        view.addSubviews(
            todosLabel,
            planetLabel,
            residentsTableView
        )
        
        residentsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            todosLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            todosLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todosLabel.heightAnchor.constraint(equalToConstant: 20),
            todosLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            
            planetLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            planetLabel.topAnchor.constraint(equalTo: todosLabel.bottomAnchor, constant: 5),
            planetLabel.heightAnchor.constraint(equalToConstant: 20),
            planetLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            
            residentsTableView.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 5),
            residentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            residentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            residentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTableView() {
        residentsTableView.register(ResidentsTableViewCell.self, forCellReuseIdentifier: String(describing: ResidentsTableViewCell.self))
        
        residentsTableView.dataSource = self
        residentsTableView.delegate = self
    }
    
    private func changeLabelsFromJSON() {
        // MARK: - 1.4
        viewModel.getLabelTextFromJSONSerialization { [weak self] (str) in
            DispatchQueue.main.async {
                self?.todosLabel.text = str
            }
        }
        
        // MARK: - 2.4
        viewModel.getLabelTextFromJSONDecoding { [weak self] (str) in
            DispatchQueue.main.async {
                self?.planetLabel.text = str
                // MARK: - 3.9
                self?.residentsTableView.reloadData()
            }
        }
    }
    
}

// MARK: - Extensions
extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.residentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let residentsTableViewCell = tableView.dequeueReusableCell(withIdentifier:  String(describing: ResidentsTableViewCell.self), for: indexPath) as! ResidentsTableViewCell
        
        let resident = viewModel.residentsArray[indexPath.row]
        
        viewModel.getResidentDataFromJSONDecoding(urlText: resident) { [weak self] (str) in
            DispatchQueue.main.async {
                residentsTableViewCell.resident = str
                self?.viewModel.residentsArray[indexPath.row] = str
            }
        }
        
        return residentsTableViewCell
    }
    
}
