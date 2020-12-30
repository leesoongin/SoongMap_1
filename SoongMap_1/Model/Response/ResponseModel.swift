//
//  ResponseModel.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/30.
//

import UIKit

struct SearchKeyWordResponseModel : Codable {
    let meta : Meta
    let documents : [Document]
    enum CodingKeys : String,CodingKey {
        case documents
        case meta
    }
}

struct SearchCategoryResponseModel :Codable {
    let documents : [Document]
    
    enum CodingKeys : String,CodingKey {
        case documents
    }
}

struct Meta : Codable {
    let total_count : Int
    let is_end : Bool
    enum CodingKeys : String,CodingKey {
        case total_count
        case is_end
    }
}

struct Document : Codable{
    let id : String
    let place_name : String
    let category_group_code : String // 카테고리 그룹 코드
    let category_group_name : String // 카테고리 그룹 명
    let phone : String // 폰 번호
    let address_name : String // 지번 주소
    let road_address_name : String // 도로명 주소
    let x : String
    let y : String
    let place_url : String
    let distance : String
    
    enum CodingKeys : String, CodingKey {
        case id
        case place_name
        case category_group_code
        case category_group_name
        case phone
        case address_name
        case road_address_name
        case x
        case y
        case place_url
        case distance
    }
}

