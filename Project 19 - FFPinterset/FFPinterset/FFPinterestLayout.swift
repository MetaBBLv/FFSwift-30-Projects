//
//  FFPinterestLayout.swift
//  FFPinterset
//
//  Created by zhou on 2019/7/12.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    var photoHeight: CGFloat = 0.0
    
    // override the method to ensure photoHeight is set when copied
    override func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    // compare photoHeight of attibutes
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes {
            if (attributes.photoHeight == photoHeight) {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class FFPinterestLayout: UICollectionViewLayout {

    var delegate: PinterestLayoutDelegate!
    
    var numberOfColums = 2
    var cellPadding: CGFloat = 6.0
    
    fileprivate var cache = [PinterestLayoutAttributes]()
    
    fileprivate var contentHeight: CGFloat = 0.0
    
    fileprivate var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        if cache.isEmpty {
            // get column width
            let columnWidth = contentWidth / CGFloat(numberOfColums)
            
            // set up xOffset
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColums {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            
            // set up yOffset
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColums)
            
            // set up every item
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = columnWidth - cellPadding * 2
                let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
                let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
                let height = cellPadding + photoHeight + annotationHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // cache attributes for each item
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                cache.append(attributes)
                
                //
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColums - 1) ? 0 : column + 1
                
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache
        {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override class var layoutAttributesClass: AnyClass {
        return PinterestLayoutAttributes.self
    }
    
}
