//
//  Cacher.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

class Cacher {
    
    fileprivate let cache = NSCache<NSString, NSData>()
    fileprivate var memoryWarningObserver: NSObjectProtocol!
    
    static let sharedInstance = Cacher()
    
    private init() {
        memoryWarningObserver = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(memoryWarningObserver)
    }
    
    func updateCacheLimit(toLimit limit: Int) {
        cache.countLimit = limit
    }
    
    func fileData(forKey key: String) -> NSData? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(fileData: NSData, forKey key: String) {
        cache.setObject(fileData, forKey: key as NSString)
    }
        
    func removeFileData(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    
    
}
