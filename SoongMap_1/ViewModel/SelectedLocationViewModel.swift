//
//  SelectedLocation.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit


class SelectedLocationManager{
    static let shared = SelectedLocationManager()
    
    var selectedLocation = [Location]() // 맨 처음 빈 리스트
    
    func addLocation(_ lat : Double , _ lng : Double){
        let location = Location(lat: lat, lng: lng)
        
        selectedLocation.append(location)
    }
    
    func deleteLocation(_ lat : Double, _ lng : Double){
        selectedLocation = selectedLocation.filter { $0.lat != lat && $0.lng != lng }
    }
}

class SelectedLocationViewModel {
    private let manager = SelectedLocationManager.shared
    
    var selectedLocation : [Location] {
        return manager.selectedLocation
    }
    
    func addLocation(lat : Double, lng : Double){
        return manager.addLocation(lat, lng)
    }
    
    func deleteLocation(lat : Double, lng : Double){
        return manager.deleteLocation(lat, lng)
    }
}
