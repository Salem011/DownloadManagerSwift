//
//  DownloadManager.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

class DownloadManager {
 
    static func loadImage(fromUrl urlString: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        
        guard let url = URL(string: urlString) else {
            let invalidError = NSError(domain: "", code: 0, userInfo: nil)
            completion(nil, invalidError)
            return
        }
        
        // Retrieve Cached Image if any
        if let cachedImageData = Cacher.sharedInstance.fileData(forKey: urlString) {
            let data = Data(referencing: cachedImageData)
            let cachedImage = UIImage(data: data)
            completion(cachedImage, nil)
            return
        }
        
        // Download the image
        Downloader.downloadFile(from: url) { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            // cache the downloaded file data
            Cacher.sharedInstance.save(fileData: NSData(data: data!),forKey: urlString)
            let downloadedImage = UIImage(data: data!)
            completion(downloadedImage, error)
        }
    }
    

   
    
}


