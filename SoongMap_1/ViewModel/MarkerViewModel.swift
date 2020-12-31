//
//  MarkerViewModel.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2021/01/01.
//

import UIKit
import NMapsMap

class MarkerManager {
    static let shared = MarkerManager()
    
    var markers = [Marker]()

    func addMarker(_ marker : Marker){
        markers.append(marker)
    }
}

class MarkerViewModel {
    private let manager = MarkerManager.shared
    
    var markers : [Marker]{
        return manager.markers
    }
    
    func addMarker(marker : Marker){
        return manager.addMarker(marker)
    }
}
