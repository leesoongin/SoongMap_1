//
//  Location.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit


struct Location{
    let placeInfo : Document
    let option : SearchOption
    init (placeInfo : Document, option : SearchOption){
        self.placeInfo = placeInfo
        self.option = option
    }
}


struct SearchOption {
    //default option으로 radius 1000, sort accurancy
    let radius : Int
    let sort : String
    
    init(radius : Int = 1000, sort : String = "accurancy") {
        self.radius = radius
        self.sort = sort
    }
}
