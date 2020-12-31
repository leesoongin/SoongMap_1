//
//  searchLocationViewController.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit
import NMapsMap

class SearchLocationViewController: UIViewController {
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var searchController : UISearchController!
    
    let selectedLocationViewModel = SelectedLocationViewModel() // 선택된 셀 추가
    let searchedLocationViewModel = SearchedLocationViewModel() // 검색된 셀 저장
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //검색에 이용되는 것들이 정의 되어 있음
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self //updater 콜백 메서드 -> updateSearchResults extension
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.backgroundImage = UIImage() // searchBar background image 없애기
        //searchController 안의 searchBar 이용하기
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self // searchBar delegate 설정, Delegate extension
    }
}

//MARK: - searchController update method extension
extension SearchLocationViewController : UISearchResultsUpdating {
    //내 생각엔 이거 입력이 있을때마다 업데이트 되면서 찾아주는 기능인듯 함.
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            print("searchText --> \(searchText)")
        }
    }
}

//  검색시 해야할 일
//1. TODO : 검색 or map에서 직접 터치로 마킹
//2. TODO : 검색결과 선택하면 해당 위치에 마킹, 터치하면 해당하는 위치에 마킹.   --> 이때 검색 결과는 x,y,radius좌표는 필요 없음
//3. TODO : 마킹된 좌표를 기준으로 radius만큼 검색해서 검색된 결과 지점에 마킹, 정보 띄우기

//MARK: - searchController delegate extension
extension SearchLocationViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return } //검색어
        
        SearchKeyWordInteratorImpl.search(searchTerm,location: nil) { response in
            //TODO : 데이터 화면에 표시하기  -> searchedLocationViewModel 만들기
            //TODO : 셀 선택시, 선택된 셀에 해당하는 좌표에 마킹하기 선택시 dismiss
            for document in response.documents {
                self.searchedLocationViewModel.addLocation(document: document)
            }
            self.searchedLocationViewModel.setSearchedInfo(searchedInfo: response.meta)
            
            print("searchedLocation -- > \(self.searchedLocationViewModel.searchedLocation)")
            print("meta ----> \(self.searchedLocationViewModel.searchedInfo?.total_count)")
            
            DispatchQueue.main.async {
                self.tableView.reloadData() //searching이 다 끝난 시점에서 data reload
            }
        }
        
        
        
        searchController.isActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text , searchText.isEmpty {
        }
    }
}
//MARK: - tableView Delegate, DataSource extension
extension SearchLocationViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("totalcount --> \(searchedLocationViewModel.searchedInfo?.total_count)")
        guard let result = searchedLocationViewModel.searchedInfo?.total_count else {
            print("section error : total count is nil !!")
            return 0
        }
        return result % 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SearchedCell else {
            return UITableViewCell()
        }
        //표현할 데이터
        cell.placeName.text = searchedLocationViewModel.searchedLocation[indexPath.row].place_name
        cell.addressName.text = searchedLocationViewModel.searchedLocation[indexPath.row].address_name
        cell.categoryName.text = searchedLocationViewModel.searchedLocation[indexPath.row].category_group_name
        
        print("됬니??")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀이 선택되었을 때 searchBar 동작 x
        print("selected data---> \(searchedLocationViewModel.searchedLocation[indexPath.row])")
        searchController.isActive = false
    }
}
