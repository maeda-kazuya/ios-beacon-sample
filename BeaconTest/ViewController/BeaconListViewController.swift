//
//  BeaconListViewController.swift
//  BeaconTest
//
//  Created by Maeda Kazuya on 2018/04/15.
//

import UIKit
import CoreLocation

class BeaconListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var uuidData: UUIDData?
    var beacons: [Beacon]?
    var region: CLBeaconRegion?
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocationManager()
        startMonitoring()
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    func startMonitoring() {
        initBeacon()
        
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if let region = self.region {
                locationManager?.startRangingBeacons(in: region)
            } else {
                print("# couldn't start monitoring...")
            }
        } else {
            print("# monitoring is not available..")
        }
    }
    
    func initBeacon() {
        if let uuidStr = self.uuidData?.uuid, let uuid = UUID(uuidString: uuidStr) {
            self.region = CLBeaconRegion(proximityUUID: uuid, identifier: "your_identifier")
        } else {
            print("# couldn't create uuid...")
        }
    }
}

extension BeaconListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }
        
        let beacon = beacons?[indexPath.row]

        if let major = beacon?.major, let minor = beacon?.minor, let rssi = beacon?.rssi {
            cell?.textLabel?.text = "Major: " + major + ", Minor: " + minor + ", RSSI: " + rssi
        }

        return cell!
    }
}

extension BeaconListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .notDetermined) {
            // Show dialog to ask user to allow getting location data
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        self.beacons = []

        for beacon in beacons {
            print("\nmajor: " + String(describing: beacon.major))
            print("minor: " + String(describing: beacon.minor))
            print("rssi: " + String(describing: beacon.rssi))
            
            self.beacons?.append(Beacon(major: beacon.major.description, minor: beacon.minor.description, rssi: beacon.rssi.description))
        }
        
        tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print("# didDeterminState")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("# didEnter")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("# didExit")
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("# didFail")
    }
}
