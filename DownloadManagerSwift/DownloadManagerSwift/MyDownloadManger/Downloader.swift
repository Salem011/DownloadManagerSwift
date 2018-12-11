//
//  Downloader.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import Foundation

class Downloader {
    
    static func downloadFile (from url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
                completion(nil, error)
            }else if data != nil {
                completion(data, nil)
            }else {
                let unkownError = NSError(domain: "", code: 500, userInfo: nil)
                completion(nil, unkownError)
            }
        }
        
        task.resume()
    }
    
}
