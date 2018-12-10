//
//  DownloadManagerSwiftTests.swift
//  DownloadManagerSwiftTests
//
//  Created by Salem Mohamed on 10/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import XCTest
@testable import DownloadManagerSwift

class DownloadManagerSwiftTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
        Cacher.sharedInstance.updateCacheLimit(toLimit: 0)
    }

    func testDownloadAndCache() {
        let imageUrl = "https://www.gettyimages.com/gi-resources/images/Embed/new/embed2.jpg"
        let promise = expectation(description: "Image is downloaded and cached")

        DownloadManager.loadImage(fromUrl: imageUrl) { (image, error) in
            
            if image != nil {
                // Assert caching the image data
                XCTAssertNotNil(Cacher.sharedInstance.fileData(forKey: imageUrl))
                promise.fulfill()
            }else {
                XCTFail("Failed with error: \(String(describing: error?.localizedDescription))")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCacheCountLimit () {
        
        let smallImageUrl = "https://www.gettyimages.com/gi-resources/images/Embed/new/embed2.jpg"
        let largeImageUrl = "https://wallpaperbrowse.com/media/images/3848765-wallpaper-images-download.jpg"
   
        Cacher.sharedInstance.updateCacheLimit(toLimit: 1)
        
        let promise = expectation(description: "Only 1 image is cached")
        
        DownloadManager.loadImage(fromUrl: smallImageUrl) { (image, error) in
            
            guard image != nil else {
                XCTFail("Failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            // Assert the small image is cached
            XCTAssertNotNil(Cacher.sharedInstance.fileData(forKey: smallImageUrl))
        }
        
        DownloadManager.loadImage(fromUrl: largeImageUrl) { (largeImage, error) in
            guard largeImage != nil else {
                XCTFail("Failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            // The small image is removed from the cache and the large image is saved
            XCTAssertNil(Cacher.sharedInstance.fileData(forKey: smallImageUrl))
            XCTAssertNotNil(Cacher.sharedInstance.fileData(forKey: largeImageUrl))
            promise.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

}
