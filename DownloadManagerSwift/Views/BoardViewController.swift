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
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardCollectionView.dataSource = self
        boardCollectionView.delegate = self
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
            DispatchQueue.main.async {
                self.boardCollectionView.reloadData()
            }
        }
    }


}

extension BoardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return components.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = boardCollectionView.dequeueReusableCell(withReuseIdentifier: "BoardComponentCell", for: indexPath) as! BoardComponentCell
        
        // TODO: Add a placeholder
        cell.componentImageView.image = nil
        
        DownloadManager.loadFile(fromUrl: components[indexPath.row].imageUrl, fileWrapper: ImageWrapper()) { (file, error) in
            let image = file as? UIImage
            DispatchQueue.main.async {
                cell.componentImageView.image = image
            }
        }
        
        return cell
    }
    
}

extension BoardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        // TODO: Handle different heights
        let calculatedSize = CGSize(width: widthPerItem, height: components[indexPath.row].height / 10)
        
        return calculatedSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    
}


