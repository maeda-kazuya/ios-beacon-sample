//
//  AddUUIDViewController.swift
//  BeaconTest
//
//  Created by Maeda Kazuya on 2018/04/14.
//

import UIKit

class AddUUIDViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var uuidText: UITextField!
    
    @IBAction func save(_ sender: Any) {
        guard let name = self.nameText.text, let uuid = self.uuidText.text else {
            return
        }
        
        if (uuid == "") {
            showAlert("UUIDを入力してください", message: "")
            return
        }

        UUIDMannager().save(uuid: uuid, name: name)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
