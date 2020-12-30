//
//  SearchKeyWordResponse.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/30.
//

import UIKit

private let KAKAO_KEYWORD_SEARCH_URL : String = "https://dapi.kakao.com/v2/local/search/keyword.json?"
private let HTTP_METHOD : String = "GET"
private let KAKAO_HEADER : String = "Authorization"
private let KAKAO_APP_KEY : String = "KakaoAK fa9599b6499ab461ea2adb295d7e939f"

class SearchKeyWordInteratorImpl {
    static func search(_ term : String, location : Location?, completion : @escaping (SearchKeyWordResponseModel) -> Void){
        let session = URLSession(configuration: .default)
        var urlComponents = URLComponents(string: KAKAO_KEYWORD_SEARCH_URL)!
        // require
        let query = URLQueryItem(name: "query", value: term)
        //TODO : 카테고리, x,y,radius sort , page 옵션 쿼리아이템 만들어서 추기하기
        urlComponents.queryItems?.append(query)

        var requestURL = URLRequest(url: urlComponents.url!)
        requestURL.httpMethod = HTTP_METHOD
        requestURL.addValue(KAKAO_APP_KEY, forHTTPHeaderField: KAKAO_HEADER)
    
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            guard error == nil,
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                successRange.contains(statusCode) else {
                    print("statusCode error !!")
                    return
            }
           
            guard let resultData = data else {
                    print("data error !!")
                    return
            }
            
            let data = SearchKeyWordInteratorImpl.parseData(resultData)
            completion(data!)
        }
        dataTask.resume()
    }//search
    
    static func parseData(_ data: Data) -> SearchKeyWordResponseModel? {
        let decoder = JSONDecoder()

        do {
            let response = try decoder.decode(SearchKeyWordResponseModel.self, from: data)
            let documents = response
            return documents
        } catch let error {
            print("--> parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}



