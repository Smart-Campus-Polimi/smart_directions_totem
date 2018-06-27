//
//  page2ViewController.swift
//  test1
//
//  Created by drosdesd on 26/03/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit

class BluetoothSearcher: UIViewController, UITableViewDelegate, UITableViewDataSource, BeeTeeDelegate{
   
    private var beeTeeModel = BeeTeeModel.sharedInstance
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var bluetoothPowerSwitch: UISwitch!
    @IBOutlet weak var bluetoothScanSwitch: UISwitch!
    @IBOutlet weak var labelBTSearcher: UILabel!
    
    var professor_name = Int()
    var clients = [BtClient]()

    
    
    func receivedBeeTeeNotification(notification: BeeTeeNotification) {
        myTableView.reloadData()
        //bluetoothPowerSwitch.setOn(beeTeeModel.bluetoothIsOn(), animated: true)
        //bluetoothScanSwitch.setOn(beeTeeModel.isScanning(), animated: true)
    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turnOnBt()
        beeTeeModel.startScanForDevices()
        self.labelBTSearcher.text = "Direzioni per " + directions[professor_name] + ":"
        
        beeTeeModel.subscribe(subscriber: self)
        //bluetoothPowerSwitch.setOn(beeTeeModel.bluetoothIsOn(), animated: false)
        //bluetoothScanSwitch.setOn(beeTeeModel.isScanning(), animated: false)
        print (beeTeeModel.availableDevices)
    }
    
    //return how many items are present in the bt list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clients.removeAll()
        return beeTeeModel.availableDevices.count
    }
    
    //return the bt devices found
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let beeTeeDevice = beeTeeModel.availableDevices[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCellIdentifier")!
        cell.textLabel?.text = beeTeeDevice.name
        cell.detailTextLabel?.text = beeTeeDevice.address
    
        clients.append(BtClient(bt_name: beeTeeDevice.name, mac_address: beeTeeDevice.address))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        beeTeeModel.stopScan()

        sessionUsers[userId-1].mac_address = clients[indexPath.row].mac_address
        sessionUsers[userId-1].name = clients[indexPath.row].bt_name
        
        performSegue(withIdentifier: "SegueBT", sender: self)
    }
    
    

    //DO NOT TOUCH BELOW HERE
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
