//
//  AdoptionCustomCollectionViewLayout.swift
//  Yoormi
//
//  Created by Газияв Исхаков on 31.07.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol AdoptionCustomCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class AdoptionCustomCollectionViewLayout: UICollectionViewLayout {
    
    weak var delegate: AdoptionCustomCollectionViewLayoutDelegate?
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        return .init(width: collectionView?.bounds.width ?? 0, height: contentHeight)
    }
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        return collectionView?.bounds.width ?? 0
    }
    
    override func prepare() {
      // 1
      guard
        cache.isEmpty,
        let collectionView = collectionView
        else {
          return
      }
      // 2
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset: [CGFloat] = []
      for column in 0..<numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      var column = 0
      var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
      // 3
      for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
          
        // 4
        let photoHeight = delegate?.collectionView(
          collectionView,
            heightForItemAtIndexPath: indexPath) ?? 180
        let height = cellPadding * 2 + photoHeight
        let frame = CGRect(x: xOffset[column],
                           y: yOffset[column],
                           width: columnWidth,
                           height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
          
        // 5
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
          
        // 6
        contentHeight = max(contentHeight, CGFloat(frame.maxY))
        yOffset[column] = yOffset[column] + height
        
        column = column < (numberOfColumns - 1) ? (column + 1) : 0
      }
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
}
