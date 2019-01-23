//
//  Beacon.swift
//  BeaconTest
//
//  Created by Maeda Kazuya on 2018/04/15.
//

import Foundation

class Beacon {
    var major: String
    var minor: String
    var rssi: String

    init(major: String, minor: String, rssi: String) {
        self.major = major
        self.minor = minor
        self.rssi = rssi
    }
}
