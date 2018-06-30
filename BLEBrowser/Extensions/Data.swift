//
//  Data.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 23.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation

extension Data {
    var bytes: [UInt8] {
        var byteArray = [UInt8](repeating: 0, count: self.count)
        self.copyBytes(to: &byteArray, count: self.count)
        return byteArray
    }
    
    func bytes(from offset: Int) -> [UInt8] {
        return self.subdata(in: offset..<self.count).bytes
    }
}
