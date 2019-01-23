//
//  UUIDManager.swift
//  BeaconTest
//
//  Created by Maeda Kazuya on 2018/04/14.
//  Copyright © 2018 Kazuya Maeda. All rights reserved.
//

import Foundation

class UUIDMannager {
    func save(uuid: String, name: String) {
        if let uuids = UserDefaults.standard.array(forKey: Constant.uuidsDataKey) {
            UserDefaults.standard.set(uuids + [getDataDic(uuid: uuid, name: name)], forKey: Constant.uuidsDataKey)
        } else {
            UserDefaults.standard.set([getDataDic(uuid: uuid, name: name)], forKey: Constant.uuidsDataKey)
        }
    }
    
    func remove(uuid: String) {
        if let uuids = UserDefaults.standard.array(forKey: Constant.uuidsDataKey) as? [[String: String]] {
            var updatedData: [[String: String]] = []
            
            // Copy bookmark list except for removing one
            for data in uuids {
                if (data["uuid"] == uuid) {
                    continue
                } else {
                    updatedData.append(data)
                }
            }
            
            UserDefaults.standard.set(updatedData, forKey: Constant.uuidsDataKey)
        }
    }

    private func getDataDic(uuid: String, name: String) -> [String: String] {
        var dataDic: [String: String] = [:]
        dataDic["uuid"] = uuid
        dataDic["name"] = name
        
        return dataDic
    }
}
