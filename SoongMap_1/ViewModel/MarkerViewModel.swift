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
    
    var markers = [Marker]() // 선택된 장소(마커)들  --> 탐색 기준 위치 마커
    var resultMarkers = [Marker]() // 탐색마커(markers)기준, 결과 마커 저장

    func addMarker(_ marker : Marker){
        markers.append(marker)
    }
    func addResultMarker(_ marker : Marker){
        resultMarkers.append(marker)
    }
    func clearResultMarker(){
        resultMarkers.removeAll()
    }
}

class MarkerViewModel {
    private let manager = MarkerManager.shared
    
    var markers : [Marker]{
        return manager.markers
    }
    var resultMarkers : [Marker]{
        return manager.resultMarkers
    }
    
    func addMarker(marker : Marker){
        return manager.addMarker(marker)
    }
    func addResultMarker(marker : Marker){
        return manager.addResultMarker(marker)
    }
    func clearResultMarker(){
        return manager.clearResultMarker()
    }
}
