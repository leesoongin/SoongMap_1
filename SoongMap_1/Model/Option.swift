//
//  Option.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2021/01/06.
//

import UIKit

struct Option {
    //default option으로 radius 1000, sort accurancy
    let x : String
    let y : String
    var radius : String
    let sort : String
    var page : Int
    
    mutating func updatePage(){
        self.page = self.page + 1
    }
    mutating func updateRadius(_ radius : String){
        self.radius = radius
    }
}
