//
//  UUIDListViewController.swift
//  BeaconTest
//
//  Created by Maeda Kazuya on 2018/04/14.
//

import UIKit

class UUIDListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var dataList: [UUIDData]?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let beaconListViewController = segue.destination as? BeaconListViewController, let data = sender as? UUIDData {
            beaconListViewController.uuidData = data
        }
    }
    
    @IBAction func addUUID(_ sender: Any) {
        self.performSegue(withIdentifier: "addUUID", sender: nil)
    }
    
    private func update() {
        if let datas = UserDefaults.standard.array(forKey: Constant.uuidsDataKey) as? [[String: String]] {
            dataList = []

            for data in datas {
                if let uuid = data["uuid"], let name = data["name"] {
                    dataList?.append(UUIDData(uuid: uuid, name: name))
                }
            }
        }
        
        self.tableView.reloadData()
    }
}

extension UUIDListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }

        cell?.textLabel?.text = self.dataList?[indexPath.row].name
        cell?.detailTextLabel?.text = self.dataList?[indexPath.row].uuid

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showBeaconList", sender: self.dataList?[indexPath.row])
    }
}
