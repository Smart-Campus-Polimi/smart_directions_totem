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
var directions = [""]
var directions_id = [0]
let map_url = "http://10.79.1.176/map/map.xml"


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var places: [Place]?
    
    var selected_place = 0
    
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
        
        label.text = "Vai da " + directions[row]
        selected_place = row
    }
    //**********
    
    
    //send data to the second view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from:now)
        
        sessionUsers.append(User(name: nil, mac_address: nil, place_id: directions_id[selected_place], id: nil, timestamp: dateString, color: nil))
        sessionUsers[userId].id = userId
        userId = userId + 1
        
        let profName_secController = segue.destination as! BluetoothSearcher
        profName_secController.professor_name = selected_place
    }
    
    //**** DO NOT TOUCH
    private let beeTeeModel = BeeTeeModel.sharedInstance
    //default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func fetchData()
    {
        directions = [""]
        directions_id = [0]
        let feedParser = DestinationParser()
        feedParser.parseFeed(url: map_url){
            (places) in self.places = places
            for pl in places{
                directions.append("\(pl.name)")
                directions_id.append(Int(pl.placeId)!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //******
    


}

