//
//  Data.swift
//  test1
//
//  Created by drosdesd on 28/03/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit

class Direction{
    //MARK: properties
    var professor: String
    
    //MARK: initialization
    init?(professor: String){
        
        // Initialization should fail if there is no name or if the rating is negative.
        if professor.isEmpty{
            return nil
            
        }
        self.professor = professor
    }
}
