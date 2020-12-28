//
//  searchLocationViewController.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/28.
//

import UIKit

class SearchLocationViewController: UIViewController {

    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //검색에 이용되는 것들이 정의 되어 있음
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self //updater 콜백 메서드 -> updateSearchResults extension
        searchController.obscuresBackgroundDuringPresentation = false
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
          
        }
    }
}

//MARK: - searchController delegate extension
extension SearchLocationViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if let searchText = searchBar.text {
           
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        print("wkrehd??")
        if let searchText = searchBar.text , searchText.isEmpty {
            print("취소 버튼 누름")
        }
    }
}
//MARK: - tableView Delegate, DataSource extension
extension SearchLocationViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀이 선택되었을 때 searchBar 동작 x
        searchController.isActive = false
    }
}
