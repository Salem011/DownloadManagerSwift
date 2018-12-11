//
//  DownloadedFileWrapper.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 11/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

public protocol DownloadedFileWrapper {
    func convertToFile(fromData data: Data) -> Any?
}


public class ImageWrapper: DownloadedFileWrapper {
    
    public func convertToFile(fromData data: Data) -> Any? {
        return UIImage(data: data)
    }
}


public class JsonWrapper: DownloadedFileWrapper {
    
    public func convertToFile(fromData data: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return json
        } catch {
            print("Error in converting data to json")
            return nil
        }
    }
}
