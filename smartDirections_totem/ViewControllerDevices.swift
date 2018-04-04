//
//  ViewControllerDevices.swift
//  test1
//
//  Created by drosdesd on 28/03/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit

class ViewControllerDevices: UITableViewController, BeeTeeDelegate {
    let beeTeeModel = BeeTeeModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beeTeeModel.subscribe(subscriber: self)
    }

    func receivedBeeTeeNotification(notification: BeeTeeNotification) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beeTeeModel.availableDevices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beeTeeDevice = beeTeeModel.availableDevices[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCellIdentifier")!
        cell.textLabel?.text = beeTeeDevice.name
        cell.detailTextLabel?.text = beeTeeDevice.address
        
        return cell
    }

    
}
