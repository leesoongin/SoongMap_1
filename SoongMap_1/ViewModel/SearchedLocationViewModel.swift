//
//  SearchedLocationViewModel.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/31.
//

import UIKit

class SearchedLocationManager {
    static let shared = SearchedLocationManager()
    
    var searchedLocation : [Document] = [] //검색되어 response된 결과를 담을 array
    var searchedInfo : Meta?
    
    func addLocation(_ document : Document) {
        searchedLocation.append(document)
    }
    func setSearchedInfo(_ searchedInfo : Meta?) {
        guard let info = searchedInfo else { return }
        
        self.searchedInfo = info
    }
    func clearSearchedLocation(){
        searchedLocation.removeAll()
    }
  
}

class SearchedLocationViewModel {
    private let manager = SearchedLocationManager.shared
    
    var searchedLocation : [Document] {
        return manager.searchedLocation
    }
    var searchedInfo : Meta? {
        return manager.searchedInfo
    }
    
    func addLocation(document : Document){
        return manager.addLocation(document)
    }
    func setSearchedInfo(searchedInfo : Meta?) {
        return manager.setSearchedInfo(searchedInfo)
    }
    func clearSearchedLocation(){
        return manager.clearSearchedLocation()
    }
}
