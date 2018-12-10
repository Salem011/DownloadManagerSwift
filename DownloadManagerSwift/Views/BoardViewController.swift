//
//  ViewController.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    var components = [BoardComponent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveBoardComponents()
    }
    
    // MARK: - View Support Functions
    func retrieveBoardComponents () {
        DownloadManager.loadFile(fromUrl: "http://pastebin.com/raw/wgkJgazE", fileWrapper: JsonWrapper()) { (json, error) in
            guard let jsonArray = json as? NSArray else {
                return
            }
            
            for jsonElement in jsonArray {
                if let componentJson = jsonElement as? [String: Any] {
                    self.components.append(BoardComponent(fromJson: componentJson))
                }
            }
        }
    }


}




