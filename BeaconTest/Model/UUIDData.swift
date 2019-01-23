//
//  UUIDData.swift
//  BeaconTest
//
//  Created by Maeda Kazuya on 2018/04/15.
//

import Foundation

class UUIDData {
    var name: String?
    var uuid: String
    
    init(uuid: String, name: String?) {
        self.uuid = uuid
        self.name = name
    }
}
