//
//  ResumeController.swift
//  smartDirections_totem
//
//  Created by drosdesd on 19/06/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit

class ResumeController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    
    var professor_name = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // nameLabel.text = String(myBTdev)
        placeLabel.text = professor_name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
