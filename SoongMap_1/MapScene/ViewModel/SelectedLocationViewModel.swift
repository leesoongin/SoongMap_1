//
//  SelectedLocation.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit
import NMapsMap

class SelectedLocationManager{
    static let shared = SelectedLocationManager()
    
    var selectedLocation = [Location]() // 맨 처음 빈 리스트
    
    func addLocation(_ latlng : NMGLatLng, _ radius : Int, _ sort : String){
        let location = Location(lat: latlng.lat, lng: latlng.lng, radius: radius, sort: sort)
        selectedLocation.append(location)
    }

    func deleteLocation(_ latlng : NMGLatLng){
       
    }
}

class SelectedLocationViewModel {
    private let manager = SelectedLocationManager.shared
    
    var selectedLocation : [Location] {
        return manager.selectedLocation
    }
    
    func addLocation(latlng : NMGLatLng, radius : Int = 1000, sort : String = "accurancy"){
        return manager.addLocation(latlng, radius, sort)
    }
    
    func deleteLocation(latlng : NMGLatLng){
        return manager.deleteLocation(latlng)
    }
}
