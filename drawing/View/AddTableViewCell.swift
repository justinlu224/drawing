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
}
