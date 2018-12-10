//
//  BoardComponent.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 11/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import Foundation

class BoardComponent {
    
    var id: String
    var imageUrl: String
    var width: Int
    var height: Int
    
    init(fromJson json: [String: Any]){
        id = json["id"] as? String ?? ""
        
        imageUrl = ""
        if let urls = json["urls"] as? [String: Any], let url = urls["full"] as? String {
            imageUrl = url
        }
        
        width = json["width"] as? Int ?? 0
        height = json["height"] as? Int ?? 0
    }
    
    
}
