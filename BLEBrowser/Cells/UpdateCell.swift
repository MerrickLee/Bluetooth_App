//
//  UpdateCell.swift
//  BLEBrowser
//
//  Created by Merrick Lee on 7/1/18.
//  Copyright © 2018 zirteam. All rights reserved.
//

import UIKit

class UpdateCell: UITableViewCell {
    
    var readBtnClosure: (() -> ())?
    var writeBtnClosure: (() -> ())?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        readBtnClosure?()
    }
    
   
}

