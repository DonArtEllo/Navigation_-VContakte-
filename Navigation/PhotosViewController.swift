//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Артем on 18.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let customSeparator: CGFloat = 8
    private var imageCollection: [UIImage] = []
    
    var imagePublisherFacade: ImagePublisherFacade?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Photo Gallery"
        view.addSubview(collectionView)
        
        imagePublisherFacade?.subscribe(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = CGRect(
            x: view.safeAreaInsets.left,
            y: view.safeAreaInsets.top,
            width: view.frame.width,
            height: view.frame.height - view.safeAreaInsets.top
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        imagePublisherFacade?.removeSubscription(for: self)
        imagePublisherFacade?.rechargeImageLibrary()
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        
        let photo = imageCollection[indexPath.row]
        
        cell.photo = photo
        
        return cell
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize: CGFloat
        
        cellSize = floor((collectionView.frame.width - customSeparator * 4) / 3) - 1
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: customSeparator, left: customSeparator, bottom: customSeparator, right: customSeparator)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        self.imageCollection = images
        collectionView.reloadData()
    }
    
}
