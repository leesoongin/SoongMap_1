//
//  SearchKeyWordRequest.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/29.
//

import UIKit

//TODO : ?인 이유 -> nil인지 아닌지 판단 후 queryItem추가하기 위해서

struct SearchKeyWordRequest {
    let query : String // require
    let category_group_code : String?
    let x : Double?
    let y : Double?
    let radius : Int?
    let page : Int?
    let sort : String? // distance or accuracy
}
