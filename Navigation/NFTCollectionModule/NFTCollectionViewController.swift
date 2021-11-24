//
//  NFTCollectionViewController.swift
//  Navigation
//
//  Created by Артем on 26.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

final class NFTCollectionViewController: UIViewController{
    
    private var viewModel: NFTCollectionModel
    private let processorOnThread = ImageProcessor()
        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NFTCollectionImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: NFTCollectionImageCollectionViewCell.self))
        
        collectionView.backgroundColor = .systemGray
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var goBackButton: UpgradedButton = {
        let button = UpgradedButton(titleText: "Go back to Feed", titleColor: .black, backgroundColor: .white, tapAction: actionGoBackToFeedButtonPressed)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: NFTCollectionModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog ("Start")
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = CGRect(
            x: view.safeAreaInsets.left,
            y: view.safeAreaInsets.top,
            width: view.frame.width,
            height: view.frame.height - view.safeAreaInsets.top - 150
        )
    }
    
    private func setupViews() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .cyan
        
        view.addSubviews(
            collectionView,
            goBackButton
        )
        
        let constraints = [
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goBackButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            goBackButton.widthAnchor.constraint(equalToConstant: 250),
            goBackButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func actionGoBackToFeedButtonPressed() {
        viewModel.onTapGoBackToFeed()
    }
}

extension NFTCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.nftImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NFTCollectionImageCollectionViewCell.self), for: indexPath) as! NFTCollectionImageCollectionViewCell
                        
        let identifier = indexPath.row
        cell.representedIdentifier = identifier
        
        // MARK: - 4
        processorOnThread.processImagesOnThread(sourceImages: viewModel.nftImages, filter: .colorInvert, qos: .userInteractive) { (processedImages) in
            DispatchQueue.main.async {
                cell.configure(with: UIImage(cgImage: processedImages[identifier]!))
                NSLog ("End image \(identifier)")
                
            }
        }
        
        // MARK: - 6
        // Results for filter .colorInvert
        // qos: .background - 00:01:36.570671
        //      Start - 22:13:09.882803+0300
        //      End - 22:14:46.453474+0300
        // qos: .default - 00:01:07.806278
        //      Start - 22:15:58.820805+0300
        //      End - 22:17:06.627083+0300
        // qos: .userInitiated - 00:01:01.865371
        //      Start - 22:18:50.663722+0300
        //      End - 22:19:52.529093+0300
        // qos: .userInteractive - 00:00:59.205161 (Smth went wrong w/ my pc 00:01:04.952689)
        //      Start - 22:30:53.220713+0300 (22:23:09.824422+0300)
        //      End - 22:31:50.425874+0300 (22:24:14.777111+0300)
        // qos: .utility - 00:00:57.729279
        //      Start - 22:26:50.179010+0300
        //      End - 22:27:47.908289+0300
        
        // Results for filter .monochrome(color: .red, intensity: 2)
        // qos: .background - 00:01:22.452252
        //      Start - 21:54:24.054374+0300
        //      End - 21:55:46.506626+0300
        // qos: .default - 00:01:07.360087
        //      Start - 21:57:27.543162+0300
        //      End - 21:58:34.903249+0300
        // qos: .userInitiated - 00:01:06.042581
        //      Start - 22:01:18.888109+0300
        //      End - 22:02:24.930690+0300
        // qos: .userInteractive - 00:01:02.854655
        //      Start - 22:05:56.789858+0300
        //      End - 22:06:59.644513+0300
        // qos: .utility - 00:01:04.672649
        //      Start - 22:10:26.680979+0300
        //      End - 22:11:31.353628+0300
        
        return cell
    }
    
}

extension NFTCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize: CGFloat
        
        cellSize = floor((collectionView.frame.width - 32) / 3) - 1
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
