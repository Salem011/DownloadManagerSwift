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
    
    var imageWrapper: ImageWrapper!
    
    override func setUp() {
        imageWrapper = ImageWrapper()
    }

    override func tearDown() {
        Cacher.sharedInstance.updateCacheLimit(toLimit: 0)
        imageWrapper = nil
    }

    func testDownloadAndCache() {
        let imageUrl = "https://www.gettyimages.com/gi-resources/images/Embed/new/embed2.jpg"
        let promise = expectation(description: "Image is downloaded and cached")

        DownloadManager.loadFile(fromUrl: imageUrl, fileWrapper: imageWrapper) { (file, error) in
            let image = file as? UIImage
            
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
   
        // Update the cache limit to 1 object only
        Cacher.sharedInstance.updateCacheLimit(toLimit: 1)
        
        let promise = expectation(description: "Only 1 image is cached")
        
        // Download the small image
        DownloadManager.loadFile(fromUrl: smallImageUrl, fileWrapper: imageWrapper) { (file, error) in
            let image = file as? UIImage
            
            guard image != nil else {
                XCTFail("Failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            // Assert the small image is cached
            XCTAssertNotNil(Cacher.sharedInstance.fileData(forKey: smallImageUrl))
        }
        
        // Download the large image
        DownloadManager.loadFile(fromUrl: largeImageUrl, fileWrapper: imageWrapper) { (file, error) in
            let largeImage = file as? UIImage
            guard largeImage != nil else {
                XCTFail("Failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            // The small image is removed from the cache and the large image is saved
            XCTAssertNil(Cacher.sharedInstance.fileData(forKey: smallImageUrl))
            XCTAssertNotNil(Cacher.sharedInstance.fileData(forKey: largeImageUrl))
            promise.fulfill()
        }

        waitForExpectations(timeout: 8, handler: nil)
    }

}
