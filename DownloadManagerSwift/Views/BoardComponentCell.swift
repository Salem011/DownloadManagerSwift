//
//  BoardComponentCell.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 11/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

class BoardComponentCell: UICollectionViewCell {

    @IBOutlet weak var componentImageView: UIImageView!
    @IBOutlet weak var componentActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        componentImageView.layer.cornerRadius = 5
        componentImageView.clipsToBounds = true
        
        componentActivityIndicator.isHidden = true
    }
    
    
    func showIndicator () {
        cell.componentActivityIndicator.isHidden = false
        cell.componentActivityIndicator.startAnimating ()
    }
    
    func hideIndicator () {
        cell.componentActivityIndicator.isHidden = true
        cell.componentActivityIndicator.stopAnimating ()
    }
}
