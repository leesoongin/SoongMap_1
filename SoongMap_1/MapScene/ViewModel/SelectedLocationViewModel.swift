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
    
    func addLocation(_ latlng : NMGLatLng, _ overlayID : String, _ radius : Double){
        let location = Location(lat: latlng.lat, lng: latlng.lng, radius : radius, overlayID: overlayID)
        //TODO[x] : 추가할 원소가 배열에 존재한다면 filter로 제외
        //TODO[x] : filtering된 배열에 append
        selectedLocation = selectedLocation.filter{ $0.overlayID != location.overlayID }
        selectedLocation.append(location)
    }

    func deleteLocation(_ latlng : NMGLatLng){
        selectedLocation = selectedLocation.filter { $0.lat != latlng.lat && $0.lng != latlng.lng }
    }
}

class SelectedLocationViewModel {
    private let manager = SelectedLocationManager.shared
    
    var selectedLocation : [Location] {
        return manager.selectedLocation
    }
    
    func addLocation(latlng : NMGLatLng, overlayID : String, radius : Double){
        return manager.addLocation(latlng, overlayID, radius)
    }
    
    func deleteLocation(latlng : NMGLatLng){
        return manager.deleteLocation(latlng)
    }
}
