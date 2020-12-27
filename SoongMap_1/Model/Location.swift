//
//  Location.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit


struct Location{
    var lat : Double
    var lng : Double
    
    init() {
        self.lat = 0
        self.lng = 0
    }
    
    init (lat : Double, lng : Double){
        self.lat = lat
        self.lng = lng
    }
}
