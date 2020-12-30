//
//  Location.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit


struct Location{
    let lat : Double
    let lng : Double
    let radius : Int
    let sort : String
    let placeInfo : Document?
    
    init() {
        self.lat = 0
        self.lng = 0
        self.radius = 0
        self.sort = ""
        self.placeInfo = nil  // wl
    }
    
    init (lat : Double, lng : Double, radius : Int = 1000, sort : String = "accurancy", placeInfo : Document? = nil){
        self.lat = lat
        self.lng = lng
        self.radius = radius
        self.sort = sort
        self.placeInfo = placeInfo
    }
}


