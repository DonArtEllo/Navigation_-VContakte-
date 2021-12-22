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
    private var processedImages = [CGImage]()
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
        
        processImages()
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
    
    // MARK: - 4
    private func processImages() {
        NSLog ("Start")
        processorOnThread.processImagesOnThread(sourceImages: viewModel.nftImages, filter: .monochrome(color: .red, intensity: 2), qos: .background)
            { (resultImages) in
                DispatchQueue.main.async {
                    for image in resultImages {
                        self.processedImages.append(image!)
                    }
                    self.collectionView.reloadData()
                    NSLog ("Ended")
                }
            }
    }
    
    // MARK: - 6
    // REWORKED
    // Results for filter .colorInvert
    // qos: .background - 00:00:52.073272
    //      Start - 14:07:25.892864+0300
    //      End - 14:08:17.966136+0300
    // qos: .default - 00:00:35.895115
    //      Start - 14:08:17.966136+0300
    //      End - 14:08:53.861251+0300
    // qos: .userInitiated - 00:00:07.824310
    //      Start - 14:09:29.391638+0300
    //      End - 14:09:37.215948+0300
    // qos: .userInteractive - 00:00:06.319278
    //      Start - 14:10:16.377426+0300
    //      End - 14:10:22.696704+0300
    // qos: .utility - 00:00:07.363522
    //      Start - 14:13:34.040710+030
    //      End - 14:13:41.404232+030
    
    // Results for filter .monochrome(color: .red, intensity: 2)
    // qos: .background - 00:00:58.633476
    //      Start - 14:18:35.648834+0300
    //      End - 14:19:34.282314+0300
    // qos: .default - 00:00:06.826707
    //      Start - 14:17:58.109966+0300
    //      End - 14:18:04.936673+0300
    // qos: .userInitiated - 00:00:06.279666
    //      Start - 14:17:11.749657+0300
    //      End - 14:17:18.029323+0300
    // qos: .userInteractive - 00:00:06.220320
    //      Start - 14:15:49.643073+0300
    //      End - 14:15:55.863393+0300
    // qos: .utility - 00:00:08.797772
    //      Start - 14:14:40.625087+0300
    //      End - 14:14:49.422859+0300
    
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
        
        DispatchQueue.main.sync { [self] in
            if !processedImages.isEmpty {
                cell.configure(with: UIImage(cgImage: processedImages[identifier]))
            } else {
                cell.configure(with: viewModel.nftImages[identifier])
            }
        }
                
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
