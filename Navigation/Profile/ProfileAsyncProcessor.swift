//
//  ProfileAsyncProcessor.swift
//  Navigation
//
//  Created by Артем on 08.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileAsyncProcessor {
    
    var filters: [Int : ColorFilter] = [
        0 : .colorInvert,
        1 : .motionBlur(radius: 5),
        2 : .bloom(intensity: 2),
        3 : .fade
    ]
    
    var processedImages: [Int : UIImage] = [:]
    
    func process(
        for identifier: Int,
        handler: @escaping (UIImage?) -> Void
    ) {
        
        let processor = ImageProcessor()
        let clearImage = UIImage(imageLiteralResourceName: Storage.postsTabel[0].postsOnProfilePage[identifier].image)
        
        processor.processImageAsync(sourceImage: clearImage, filter: filters[identifier] ?? .chrome) { processedImage in
            print("Yeah - Complete image processing! Saving processed image to cache...")
            guard let processedImage = processedImage else {
                return
            }
            
            self.processedImages[identifier] = UIImage(cgImage: processedImage)
            
            handler(self.processedImages[identifier])
        }
        
        print("Cheking processedImages...")
        guard processedImages[identifier] != nil else {
            print("Nope - no image for \(identifier)")
            return
        }
    }
    
}

