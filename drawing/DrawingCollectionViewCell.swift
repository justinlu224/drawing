//
//  DrawingCollectionViewCell.swift
//  drawing
//
//  Created by Apple on 2019/3/6.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class DrawingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quzLabel: UILabel!
    @IBOutlet weak var dele: UIButton!

    @IBAction func clickDeleteBtn(_ sender: UIButton) {
        print("AAAAAAAAAAAAAA")
        var cell:UICollectionViewCell = imageView.superview?.superview as! UICollectionViewCell
        var cv = cell.superview as! UICollectionView
        var index = cv.indexPath(for: cell)
        print("index = \(index!)")
    }
    
}
