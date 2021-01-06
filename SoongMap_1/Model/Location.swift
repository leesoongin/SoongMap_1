//
//  Location.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit


struct Location{
    let placeInfo : Document
    let option : Option?
    init (placeInfo : Document, option : Option?){
        self.placeInfo = placeInfo
        self.option = option
    }
}


