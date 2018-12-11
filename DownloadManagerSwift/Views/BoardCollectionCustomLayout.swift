//
//  BoardCollectionCustomLayout.swift
//  DownloadManagerSwift
//
//  Created by Salem Mohamed on 11/12/2018.
//  Copyright © 2018 Salem Mohammed. All rights reserved.
//

import UIKit

protocol  BoardCollectionCustomLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

class BoardCollectionCustomLayout: UICollectionViewLayout {

    weak var delegate: BoardCollectionCustomLayoutDelegate!
    
    fileprivate let contentInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate let itemsPerRow = 2

    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat = 0
    
    fileprivate var previousAttributes = [UICollectionViewLayoutAttributes]()

    override var collectionViewContentSize: CGSize {

        guard let collectionView = collectionView else {
            return CGSize(width: 0, height: 0)
        }
        
        let collectionInsets = collectionView.contentInset
        contentWidth = collectionView.bounds.width - (collectionInsets.left + collectionInsets.right)
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override public func prepare() {
        if previousAttributes.isEmpty {
            collectionView?.contentInset = contentInsets
            let columnWidth = contentWidth / CGFloat(itemsPerRow)
            var xOffset = [CGFloat]()
            for column in 0 ..< itemsPerRow {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            let headerHeight: CGFloat = 0
            
            var yOffset = [CGFloat](repeating: headerHeight, count: itemsPerRow)
            var col = 0
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                
                let cellHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath)
                let height = contentInsets.left +  cellHeight + contentInsets.left
                let frame = CGRect(x: xOffset[col], y: yOffset[col], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: contentInsets.left, dy: contentInsets.left)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                previousAttributes.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[col] = yOffset[col] + height
                
                col = col >= (itemsPerRow - 1) ? 0 : col+1
            }
            
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in previousAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
}

