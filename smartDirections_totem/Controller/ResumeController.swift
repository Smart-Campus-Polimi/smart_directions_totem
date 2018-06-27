//
//  ResumeController.swift
//  smartDirections_totem
//
//  Created by drosdesd on 19/06/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit
import Moscapsule

let arrowColors = ["verdi", "blu", "rosse", "bianche"]
let arrowColMqtt = ["green", "blue", "red", "white"]
let topicName = "topic/rasp4/directions"
let broker = "10.79.1.176"
var arrowNumber = 0


class ResumeController: UIViewController {

    private let beeTeeModel = BeeTeeModel.sharedInstance
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!

    @IBOutlet weak var okButton: UIButton!
    let mqttClient = MQTT.newConnection(MQTTConfig(clientId: "client_cid", host: broker, port: 1883, keepAlive: 120))
    var effect:UIVisualEffect!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mqttClient.reconnect()
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        addItemView.layer.cornerRadius = 5
        
        
        arrowNumber = getArrow()
	        sessionUsers[userId-1].color = String(arrowColMqtt[(arrowNumber%4)])
        
        let index = directions_id.index(of: Int(sessionUsers[userId-1].place_id!))
        placeLabel.text = "Indicazioni per " + String(directions[index!])
        nameLabel.text = "Ciao " + String(sessionUsers[userId-1].name!) + "!"
        arrowLabel.text = "Segui le freccie " + String(arrowColors[(arrowNumber%4)])
        arrowImgView.image = UIImage(named: String(arrowColors[(arrowNumber%4)]) + ".png")
        
        print("arrow num")
        print(arrowNumber)
        
    }
  
    @IBAction func goBack(_ sender: Any) {
        mqttClient.disconnect()
    }
    
    fileprivate func getArrow() -> Int{
        return UserDefaults.standard.integer(forKey: "colorNumber")
    }
    
    
    @IBAction func confirmAction(_ sender: AnyObject) {
        sendMQTT()
        animateIn()
        okButton.isHidden = true
    }
    
    @IBAction func dismissPopUp(_ sender: Any) {
        //sendMQTT()
        animateOut()
    }
    
    
    func animateIn(){
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
        addItemView.alpha = 0
        arrowNumber += 1
        UserDefaults.standard.set(arrowNumber, forKey: "colorNumber")
        UserDefaults.standard.synchronize()
        
        UIView.animate(withDuration: 0.4){
            self.visualEffectView.effect = self.effect
            self.addItemView.alpha = 1
            self.addItemView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.addItemView.transform = CGAffineTransform.init(scaleX:1.3, y:1.3)
            self.addItemView.alpha = 0
            
            self.visualEffectView.effect = nil
        }) {(success:Bool) in
                self.addItemView.removeFromSuperview()
            
            
        }
        mqttClient.disconnect()

        
        
    }
    
    func sendMQTT(){
        do {
            let jsonData = try JSONEncoder().encode(sessionUsers[userId-1])
            let jsonString = String(data: jsonData, encoding: .utf8)!

            mqttClient.publish(string: jsonString, topic: topicName, qos: 2, retain: false)
            print ("Send mqtt msg")
            
        } catch { print(error) }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
