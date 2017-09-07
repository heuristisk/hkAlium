//
//  ViewController.swift
//  customCollectionView
//
//  Created by Anderson Gusmão on 9/6/17.
//  Copyright © 2017 Heuristisk. All rights reserved.
//

import UIKit
import hkAlium

class ViewController: UICollectionViewController, CustomLayoutDelegate {
    
    public var customCollectionViewLayout: UICustomCollectionViewLayout? {
        get {
            return collectionViewLayout as? UICustomCollectionViewLayout
        }
        set {
            if newValue != nil {
                self.collectionView?.collectionViewLayout = newValue!
            }
        }
    }
    
    struct Model {
        var index: Int
        var isBig: Bool
    }
    
    private let dataSet = [Model(index: 1, isBig: true), Model(index: 2, isBig: false), Model(index: 3, isBig: false),
                           Model(index: 4, isBig: true), Model(index: 5, isBig: true), Model(index: 6, isBig: false),
                           Model(index: 7, isBig: false), Model(index: 8, isBig: false), Model(index: 9, isBig: false),
                           Model(index: 10, isBig: false), Model(index: 11, isBig: false), Model(index: 12, isBig: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customCollectionViewLayout?.delegate = self
        self.customCollectionViewLayout?.numberOfColumns = 1
        //self.customCollectionViewLayout?.cellPadding = 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSet.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICustomCollectionViewCell", for: indexPath) as? UICustomCollectionViewCell
        cell?.label.text = "\(dataSet[indexPath.row].index)"
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAt
                        indexPath: IndexPath,
                        with width: CGFloat) -> CGFloat {
        
        let heightSizes = [100,216]
        return CGFloat(heightSizes[dataSet[indexPath.row].isBig ? 1 : 0])
    }
}
