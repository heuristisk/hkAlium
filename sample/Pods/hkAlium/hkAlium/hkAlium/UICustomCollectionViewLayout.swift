//
//  UICustomCollectionViewLayout.swift
//  customCollectionView
//
//  Created by Anderson Gusmão on 9/6/17.
//  Copyright © 2017 Heuristisk. All rights reserved.
//

import UIKit

public protocol CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}

public class UICustomCollectionViewLayout: UICollectionViewLayout {
    
    public var delegate: CustomLayoutDelegate!
    private var showHeader = false
    private var showFooter = false
    
    public var numberOfColumns = 2
    public var cellPadding: CGFloat = 8.0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override public func prepare() {
        if cache.isEmpty {
            collectionView?.contentInset = UIEdgeInsets(top: 0, left: cellPadding, bottom: cellPadding, right: cellPadding)
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            let headerHeight: CGFloat
            if self.showHeader {
                headerHeight = 88
                let a = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: IndexPath(item: 1, section: 0))
                a.frame = CGRect(x: cellPadding, y: contentHeight + cellPadding, width: contentWidth - (cellPadding*2), height: 185)
                contentHeight = max(contentHeight, a.frame.maxY + cellPadding)
                cache.append(a)
            } else {
                headerHeight = 0
            }
            
            var yOffset = [CGFloat](repeating: headerHeight, count: numberOfColumns)
            var col = 0
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = columnWidth - cellPadding * 2
                
                let cardHeight = delegate.collectionView(collectionView!, heightForItemAt: indexPath, with: width)
                let height = cellPadding +  cardHeight + cellPadding
                let frame = CGRect(x: xOffset[col], y: yOffset[col], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[col] = yOffset[col] + height
                
                col = col >= (numberOfColumns - 1) ? 0 : col+1
            }
            
            if (showFooter) {
                
                let a = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: IndexPath(item: 1, section: 0))
                a.frame = CGRect(x: cellPadding, y: contentHeight + cellPadding, width: contentWidth - (cellPadding*2), height: 185)
                contentHeight = max(contentHeight, a.frame.maxY + cellPadding)
                cache.append(a)
            }
        }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
