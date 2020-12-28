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
    var radius : Double // 적용 범위
    let overlayID : String
    
    init() {
        self.lat = 0
        self.lng = 0
        self.radius = 0
        self.overlayID = ""
    }
    
    init (lat : Double, lng : Double, radius : Double, overlayID : String){
        self.lat = lat
        self.lng = lng
        self.radius = radius
        self.overlayID = overlayID
    }
}
