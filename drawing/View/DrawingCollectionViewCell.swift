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
    @IBOutlet weak var deleteBtn: UIButton!
    var delegate: DrawingCellDelegate?
    
    var isEditing:Bool = false{
        didSet{
            deleteBtn.isHidden = !isEditing
        }
    }
    
    @IBAction func clickDeleteBtn(_ sender: UIButton) {
        delegate?.delete(cell: self)
    }
    
}
