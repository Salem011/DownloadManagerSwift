//
//  Cacher.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import Foundation

class Cacher {
    
    private let cache = NSCache<NSString, NSData>()
    
    static let sharedInstance = Cacher()
    
    private init() {
    }
    
    func fileData(forKey key: String) -> NSData? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(fileData: NSData, forKey key: String) {
        cache.setObject(fileData, forKey: key as NSString)
    }
    
}
