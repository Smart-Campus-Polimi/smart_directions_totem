//
//  ResumeController.swift
//  smartDirections_totem
//
//  Created by drosdesd on 19/06/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit
import Moscapsule

let topicName = "topic/rasp4/directions"
let broker = "10.172.0.11"

class ResumeController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet var addItemView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!

    let mqttClient = MQTT.newConnection(MQTTConfig(clientId: "client_cid", host: broker, port: 1883, keepAlive: 60))
    var effect:UIVisualEffect!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mqttClient.reconnect()
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        
        addItemView.layer.cornerRadius = 5
        
        placeLabel.text = "Indicazioni per " + String(sessionUsers[userId-1].place_id!)
        nameLabel.text = "Ciao " + String(sessionUsers[userId-1].name!) + "!"
        
        
        
        
    }
  
    @IBAction func confirmAction(_ sender: AnyObject) {
        sendMQTT()
        animateIn()
    }
    
    @IBAction func dismissPopUp(_ sender: Any) {
        sendMQTT()
        animateOut()
    }
    
    
    func animateIn(){
        self.view.addSubview(addItemView)
        addItemView.center = self.view.center
        
        addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
        addItemView.alpha = 0
        
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

            
        } catch { print(error) }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
