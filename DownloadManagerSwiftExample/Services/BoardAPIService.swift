//
//  BoardAPIService.swift
//  DownloadManagerSwiftExample
//
//  Created by Salem Mohamed on 11/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import Foundation
import DownloadManagerSwift

class BoardAPIService {
    
    let url = "http://pastebin.com/raw/wgkJgazE"
    
    var boardComponents = [BoardComponent]()
    
    var currentPage = 0
    var itemsPerPage = 10
    
    func loadBoardComponents (completion: @escaping ([BoardComponent], Error?) -> ()) {
        // TODO: pass it the url if the url supports pagination.
        currentPage += 1
        
        DownloadManager.loadFile(fromUrl: url, fileWrapper: JsonWrapper()) { (json, error) in
            
            guard let jsonArray = json as? NSArray else {
                completion(self.boardComponents, error)
                return
            }
            
            // Because the request is not supporting pagination, I am assuming the page has only 1 page, when removing this if block, the pagination should work fine
            if self.currentPage > 1 || jsonArray.count == 0 {
                self.currentPage -= 1
                completion(self.boardComponents, nil)
                return
            }
            
            // TODO: Uncomment this when pagination is supported
//            if jsonArray.count == 0 {
//                self.currentPage -= 1
//                completion(self.boardComponents, nil)
//                return
//            }
            
            for jsonElement in jsonArray {
                if let componentJson = jsonElement as? [String: Any] {
                    self.boardComponents.append(BoardComponent(fromJson: componentJson))
                }
            }
            completion(self.boardComponents, nil)
        }
    }
    
}
