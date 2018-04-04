//
//  page2ViewController.swift
//  test1
//
//  Created by drosdesd on 26/03/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit

class page2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BeeTeeDelegate{
    
    private let beeTeeModel = BeeTeeModel.sharedInstance
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var bluetoothPowerSwitch: UISwitch!
    @IBOutlet weak var bluetoothScanSwitch: UISwitch!
    @IBOutlet weak var labelPage2: UILabel!
    var professor_name = String()
    
    func receivedBeeTeeNotification(notification: BeeTeeNotification) {
        myTableView.reloadData()
        //bluetoothPowerSwitch.setOn(beeTeeModel.bluetoothIsOn(), animated: true)
        //bluetoothScanSwitch.setOn(beeTeeModel.isScanning(), animated: true)
    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turnOnBt()
        startScanning()
        self.labelPage2.text = professor_name
        
        beeTeeModel.subscribe(subscriber: self)
        //bluetoothPowerSwitch.setOn(beeTeeModel.bluetoothIsOn(), animated: false)
        //bluetoothScanSwitch.setOn(beeTeeModel.isScanning(), animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beeTeeModel.availableDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Popola table view")
        print(indexPath.row)
        //print("index path length")
        //print(indexPath.count)
        let beeTeeDevice = beeTeeModel.availableDevices[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCellIdentifier")!
        cell.textLabel?.text = beeTeeDevice.name
        cell.detailTextLabel?.text = beeTeeDevice.address
        
        return cell
    }
    
    func turnOnBt(){
        if !beeTeeModel.bluetoothIsOn() {
            beeTeeModel.turnBluetoothOn()
        }
    }
    
    func startScanning(){
        if !beeTeeModel.isScanning(){
            beeTeeModel.startScanForDevices()
        }
    }
}
