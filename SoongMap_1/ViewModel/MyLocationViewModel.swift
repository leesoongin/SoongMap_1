//
//  MyLocation.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit

class MyLocationManager{
    static let shared = MyLocationManager()
    
    var myLocation : Location = Location() //초기엔 빈 값
    
    func updateMyLocation(_ lat : Double, _ lng : Double){
        myLocation = Location(lat: lat, lng: lng)
    }
}

class MyLocationViewModel {
    private let manager = MyLocationManager.shared
    
    var myLocation : Location {
        return manager.myLocation
    }
    
    func updateMyLocation(lat : Double, lng : Double){
        return manager.updateMyLocation(lat, lng)
    }
}
