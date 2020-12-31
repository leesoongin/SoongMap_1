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
    
    func addLocation(_ document : Document, _ option : SearchOption){
        selectedLocation.append(Location(placeInfo: document, option: option))
    }
    func clearLocation(){
        selectedLocation.removeAll()
    }
}

class SelectedLocationViewModel {
    private let manager = SelectedLocationManager.shared
    
    var selectedLocation : [Location] {
        return manager.selectedLocation
    }
    
    func addLocation(document : Document, option : SearchOption){
        return manager.addLocation(document,option)
    }
    func clearLocation(){
        return manager.clearLocation()
    }
}
