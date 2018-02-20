//
//  PhotoSelectorController+Handlers.swift
//  instagram_firebase
//
//  Created by Qichen Huang on 2018-02-18.
//  Copyright © 2018 Qichen Huang. All rights reserved.
//

import UIKit
import Photos

extension PhotoSelectorController {
    
    internal func fetchPhotos() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 1000
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {

            allPhotos.enumerateObjects({ (asset, count, stop) in
                
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 350, height: 350)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                    
                })
            })
        }
    }
    
    
    
    @objc func handleNext() {
        let sharePhotoController = SharePhotoController()
        sharePhotoController.selectedImage = header?.photoImageView.image
        navigationController?.pushViewController(sharePhotoController, animated: true)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
