//
//  ViewController.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DownloadManager.loadFile(fromUrl: "http://pastebin.com/raw/wgkJgazE", fileWrapper: JsonWrapper()) { (json, error) in
            print(error)
            print(json)
        }
        
//        DownloadManager.loadJson(fromUrl: "http://pastebin.com/raw/wgkJgazE") { (json, error) in
//            print(error)
//            print(json)
//        }
    }


}

