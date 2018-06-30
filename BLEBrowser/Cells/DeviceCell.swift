//
//  DeviceCell.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 21.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var identifierLbl: UILabel!
    @IBOutlet weak var rssiLbl: UILabel!
    @IBOutlet weak var connectBtn: UIButton!

    var connectBtnClosure: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func connectBtnTapped(_ sender: Any) {
        connectBtnClosure?()
    }
    
}
