//
//  DownloadManager.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

public class DownloadManager {

    /*
     Update the caching capacity limit
     */
    static func updateCachingLimit(toLimit limit: Int) {
        Cacher.sharedInstance.updateCacheLimit(toLimit: limit)
    }
    
    /*
      loading the file using the urlString from cache or download it if it is not cached and convert Data object to the file using the fileWrapper param.
     */
    static func loadFile (fromUrl urlString: String, fileWrapper: DownloadedFileWrapper, completion: @escaping (_ file: Any?, _ error: Error?) -> ()) {
     
        guard let url = URL(string: urlString) else {
            let invalidError = NSError(domain: "", code: 0, userInfo: nil)
            completion(nil, invalidError)
            return
        }
        
        // Retrieve the cached file if any
        if let cachedFileData = Cacher.sharedInstance.fileData(forKey: urlString) {
            let data = Data(referencing: cachedFileData)
            let file = fileWrapper.convertToFile(fromData: data)
            completion(file, nil)
            return
        }
        
        // Download the file
        Downloader.downloadFile(from: url) { (data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            // cache the downloaded file data
            Cacher.sharedInstance.save(fileData: NSData(data: data!),forKey: urlString)
            let file = fileWrapper.convertToFile(fromData: data!)
            completion(file, error)
        }
    }
    
}


