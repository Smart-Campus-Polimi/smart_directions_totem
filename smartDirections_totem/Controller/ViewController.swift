//
//  ViewController.swift
//  test1
//
//  Created by drosdesd on 26/03/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit

var sessionUsers = [User]()
var userId = 0

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let directions = ["Redondi", "Cesana", "Capone", "Filippini"]
    
    
    //ACTIONS:...
    
    
    //**** PICKER VIEW ****
    //how many section in one row
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //define the text of the row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return directions[row]
    }
    
    //how many rows we want
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return directions.count
    }
    
    //display the selected row in the label
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = "Go to " + directions[row]
    }
    //**********
    
    
    //send data to the second view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        sessionUsers.append(User(name: nil, mac_address: nil, place: nil, id: nil))
        sessionUsers[userId].id = userId
        userId = userId + 1
        let profName_secController = segue.destination as! BluetoothSearcher
        profName_secController.professor_name = label.text!
    }
    
    //**** DO NOT TOUCH
    private let beeTeeModel = BeeTeeModel.sharedInstance
    //default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //******
    


}

