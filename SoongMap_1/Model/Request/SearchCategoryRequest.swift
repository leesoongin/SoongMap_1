//
//  SearchCategoryRequest.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/29.
//

import UIKit

struct SearchCategoryRequest {
    let category_group_code : String //require
    let x : Double?
    let y : Double?
    let radius : Int?
    let sort : String? // distance or accuracy
}
