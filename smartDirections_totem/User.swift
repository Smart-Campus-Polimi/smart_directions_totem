//
//  user.swift
//  smartDirections_totem
//
//  Created by drosdesd on 19/06/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import Foundation

struct User : Codable{
    var name: String?
    var mac_address: String?
    var place_id: Int?
    var id: Int?
    var timestamp: String
}

struct BtClient{
    var bt_name: String
    var mac_address: String
}
