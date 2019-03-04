//
//  AddTableViewCell.swift
//  drawing
//
//  Created by Apple on 2018/11/12.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class AddTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var addTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        var v : UIView = textField
//        repeat { v = v.superview! } while !(v is UITableViewCell)
//        let cell = v as! AddTableViewCell // or UITableViewCell or whatever
//        let ip = UIViewController() as! AddViewController
//        let ap = ip.addTVC.indexPath(for: cell)
//        
//        print("textFieldDidEndEditing = \(ap)")
//        
//    }
    
}
