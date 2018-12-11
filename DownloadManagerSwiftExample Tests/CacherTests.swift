//
//  CacherTests.swift
//  DownloadManagerSwiftTests
//
//  Created by Salem Mohamed on 10/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import XCTest
@testable import DownloadManagerSwift

class CacherTests: XCTestCase {

    var cacherToTest: Cacher!
    
    override func setUp() {
        cacherToTest = Cacher.sharedInstance
    }

    override func tearDown() {
        cacherToTest = nil
    }

    func testSaveToCache () {
        let key = "TestKey"
        
        cacherToTest.save(fileData: NSData(), forKey: key)
        XCTAssertNotNil(cacherToTest.fileData(forKey: key))
        
        cacherToTest.removeFileData(forKey: key)
        XCTAssertNil(cacherToTest.fileData(forKey: key))

    }

}
