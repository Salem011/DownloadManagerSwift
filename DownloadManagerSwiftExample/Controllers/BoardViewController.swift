//
//  ViewController.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 08/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit
import DownloadManagerSwift

class BoardViewController: UIViewController {

    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    var components = [BoardComponent]()
    let apiService = BoardAPIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardCollectionView.dataSource = self
        
        let boardLayout = BoardCollectionCustomLayout()
        boardLayout.delegate = self
        boardCollectionView.collectionViewLayout = boardLayout
        retrieveBoardComponents()
    }
    
    // MARK: - View Support Functions
    func retrieveBoardComponents () {
        apiService.loadBoardComponents { (boardComponents, error) in
            if let errorMessage = error?.localizedDescription {
                DispatchQueue.main.async {
                    self.displayErrorAlert(withMessage: errorMessage)
                }
                return
            }
            
            self.components = boardComponents
            DispatchQueue.main.async {
                self.boardCollectionView.reloadData()
            }
        }
    }
    
    func displayErrorAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension BoardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return components.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = boardCollectionView.dequeueReusableCell(withReuseIdentifier: "BoardComponentCell", for: indexPath) as! BoardComponentCell
        
        // Add placeholder to the image cell to handle failure and avoid reuse issues
        cell.componentImageView.image = UIImage(named: "placeholder")
        
        cell.showIndicator()
        // Download board component image
        DownloadManager.loadFile(fromUrl: components[indexPath.row].imageUrl, fileWrapper: ImageWrapper()) { (file, error) in
            DispatchQueue.main.async {
                cell.hideIndicator()
            }
            
            guard let image = file as? UIImage else {
                return
            }
            
            DispatchQueue.main.async {
                cell.componentImageView.image = image
            }
        }
        return cell
    }
    
}


extension BoardViewController: BoardCollectionCustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        // Divide by 10 is just a random scaller to map the heights retrieved from the backend.
        return components[indexPath.row].height / 10
    }
}


