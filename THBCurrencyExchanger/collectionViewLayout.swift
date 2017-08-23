//
//  collectionViewLayout.swift
//  THBCurrencyExchanger
//
//  Created by kuanhuachen on 2017/8/23.
//  Copyright © 2017年 kuanhuachen. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewLayout: UICollectionViewFlowLayout {
    
    // MARK: - constants
    private let WIDTH_RATIO: CGFloat = 0.8
    //  private let MIN_SPACING: CGFloat = UIScreen.main.bounds.width / 3.413
    
    private let MIN_SPACING: CGFloat = 2
    
    // MARK: - Override
    override func prepare() {
        super.prepare()
        DispatchQueue.main.async {
            guard self.collectionView != nil else {
                return
            }
//            self.itemSize = CGSize(width: self.collectionView!.frame.width * self.WIDTH_RATIO, height: self.collectionView!.frame.height)
            
            self.itemSize = CGSize(width: self.collectionView!.frame.width * self.WIDTH_RATIO, height: self.collectionView!.frame.height * 0.8)
            
            self.scrollDirection = .horizontal
            self.minimumLineSpacing = self.MIN_SPACING
            self.minimumInteritemSpacing = self.MIN_SPACING
            
            // 務必加入以下程式碼，第0筆資料才能置中
            
            let inset = (self.collectionView!.frame.width - self.itemSize.width ) / 2
            
            self.sectionInset = UIEdgeInsets(top: 20, left: inset, bottom: 20, right: inset)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var last_Frame = self.collectionView!.frame
        
        last_Frame.origin = proposedContentOffset
        
        let attribute_Array = layoutAttributesForElements(in: last_Frame)
        
        let centerX = proposedContentOffset.x + self.collectionView!.frame.width / 2
        var adjustOffsetX = CGFloat(MAXFLOAT)
        var index = -1
        for attributes: UICollectionViewLayoutAttributes in attribute_Array! {
            if abs(attributes.center.x - centerX) < abs(adjustOffsetX) {
                index = attributes.indexPath.row
                adjustOffsetX = attributes.center.x - centerX
            }
        }
        print("targetContentOffset: \(index), \(adjustOffsetX)  ", proposedContentOffset.x)
        
        return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
    }
    
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attribute_Array = super.layoutAttributesForElements(in: rect)
        
        let centerX = self.collectionView!.frame.width / 2
        
        attribute_Array?.forEach({ (attributes) in
            
            if let copyAttribute_Array = attributes.copy() as? UICollectionViewLayoutAttributes {
                
                let deltaX = abs(centerX - (copyAttribute_Array.center.x - self.collectionView!.contentOffset.x))
                
                if deltaX < self.collectionView!.bounds.width {
                    
                    let scale =  1.0 - deltaX / ( centerX + deltaX )
                    
                    if scale < 0.5 {
                        
                        copyAttribute_Array.alpha = 0
                        
                    } else {
                        
                        copyAttribute_Array.alpha = 1
                        
                        copyAttribute_Array.transform = CGAffineTransform(scaleX: scale , y: scale)
                    }
                }
                
                attribute_Array?.append(copyAttribute_Array)
                
            }
        })
        
        
        return attribute_Array
    }
}
