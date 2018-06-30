//
//  CharacteristicCell.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 22.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import UIKit

class CharacteristicCell: UITableViewCell {

    var readBtnClosure: (() -> ())?
    var writeBtnClosure: (() -> ())?

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var uuidLbl: UILabel!
    @IBOutlet weak var propertiesLbl: UILabel!
    @IBOutlet weak var readBtn: UIButton!
    @IBOutlet weak var writeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func readBtnTapped(_ sender: Any) {
        readBtnClosure?()
    }
    
    @IBAction func writeBtnTapped(_ sender: Any) {
        writeBtnClosure?()
    }
}
