//
//  ViewController.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2020/12/27.
//

import UIKit
import NMapsMap
import CoreLocation

//TODO : 켜지자마자 내 위치 확인하고 내 위치로 시점이동 or 위치 확인이 불가하다면 default location으로 이동하자

private let DEFAULT_LOCATION = NMFCameraPosition(NMGLatLng(lat: 37.5666102, lng: 126.9783881), zoom: 15, tilt: 0, heading: 0)// 서울 시청

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var dummySearchBar: UISearchBar!
    @IBOutlet  weak var naverMapView : NMFNaverMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var compassView: NMFCompassView!
    
    var mapView : NMFMapView {
        return naverMapView.mapView
    }
    var locationManager : CLLocationManager!
    let selectedLocationViewModel = SelectedLocationViewModel()
    let markerViewModel = MarkerViewModel()
    
    private var landMarkList : [String] = ["카페","편의점","맛집","주유소","은행"]
    private var landMark : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dummySearchBar.delegate = self
        dummySearchBar.backgroundImage = UIImage()
        dummySearchBar.searchTextField.backgroundColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionView.backgroundColor = UIColor.clear
        naverMapView.showLocationButton = true //내 위치 찾기 버튼 활성화 false는 비활성화
        mapView.touchDelegate = self
        mapView.positionMode = .compass
        compassView.mapView = self.mapView
        DispatchQueue.main.async {
            self.mapView.moveCamera(NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: self.mapView.locationOverlay.location.lat, lng: self.mapView.locationOverlay.location.lng), zoom: 15, tilt: 0, heading: 0)))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registSelectedLocation() // viewModel에 선택된 장소들 마킹
        updateCamera() // 마킹된 지점중 마지막 지정된 위치로 카메라 위치 update 
    }
    
    @IBAction func searchStart(_ sender: Any) {
        for location in selectedLocationViewModel.selectedLocation {
            let x = location.placeInfo.x
            let y = location.placeInfo.y
            let option = Option(x: x, y: y, radius: "1000", sort: "accurancy", page: 1)
            nearbySearch(term: landMark, option: option)
        }
    }//search
}

//MARK: - Map Touch Delegate
extension ViewController : NMFMapViewTouchDelegate{
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("latlng -->\(selectedLocationViewModel.selectedLocation)")
    }
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        //true ->  didTapMap 호출 (이벤트 전파)   ,  false -> didTapMap 호출하지 않음 (이벤트 소비)
        print("symvol : \(symbol.caption), \(symbol.position.lat) , \(symbol.position.lng), ")
        return true
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //searching화면으로 전환
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "testVC") else{
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return landMarkList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "landMarkCell", for: indexPath) as? LandMarkCell else {
            return UICollectionViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.imageView.image = UIImage(named: "cafe")
            cell.label.text = landMarkList[indexPath.row]
        case 1:
            cell.imageView.image = UIImage(named: "convenience")
            cell.label.text = landMarkList[indexPath.row]
        case 2:
            cell.imageView.image = UIImage(named: "restaurant")
            cell.label.text = landMarkList[indexPath.row]
        case 3:
            cell.imageView.image = UIImage(named: "gas_station")
            cell.label.text = landMarkList[indexPath.row]
        default:
            cell.imageView.image = UIImage(named: "bank")
            cell.label.text = landMarkList[indexPath.row]
        }
        
        cell.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.3, height: 1.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        return cell
    }
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO : 선택된 셀을 기준으로 많이 사용하는 키워드로 검색기능 하면됨
        //옵션 기능 또 넣어서 main에서는 search로 다시 넣으면 되징
        let x = String(mapView.locationOverlay.location.lng)
        let y = String(mapView.locationOverlay.location.lat)
        var option = Option(x: x , y: y, radius: "1000", sort: "accurancy",page: 1)
        landMark = landMarkList[indexPath.row]
        nearbySearch(term: landMarkList[indexPath.row],option: option)
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 40)
    }
}

extension ViewController {
    //탐색 기준이 되는 마커들을 viewModel에 저장
    func registSelectedLocation(){
        //Marker 객체 생성해서 viewModel에 저장
        for location in selectedLocationViewModel.selectedLocation{
            let marker = NMFMarker(position: NMGLatLng(lat: Double(location.placeInfo.y)!, lng: Double(location.placeInfo.x)!))
            let document = location.placeInfo
            let result = Marker(marker: marker, document: document)
            markerViewModel.addMarker(marker: result)
        }
        //각각의 Marker객체에 touchHandler, mapView 할당
        for marker in markerViewModel.markers{
            //TODO : 상호명으로 캡션 달기
            marker.marker.captionText = marker.document.place_name
            marker.marker.isHideCollidedSymbols = true //캡션, 심벌이 충돌시 심벌 숨김
            marker.marker.touchHandler = { [weak self] (overlay : NMFOverlay) -> Bool in
                    //TODO : 인포윈도우로 정보 표현하기
                print("marker data--> \(marker.document)")
                    return true
            }
            marker.marker.mapView = mapView
        }
    }
    // 화면전환 함수
    func updateCamera(){
        //TODO[x] : 카메라 위치 이동 (가장 마지막 아이템으로)
        //TODO[x] : selectedLocation에 있는 아이템 좌표에 마킹
        guard let x = selectedLocationViewModel.selectedLocation.last?.placeInfo.x else { return }
        guard let y = selectedLocationViewModel.selectedLocation.last?.placeInfo.y else { return }
        let lng = Double(x)!
        let lat = Double(y)!
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        
        mapView.moveCamera(cameraUpdate)
    }
    ///fdasdasdsad
    //검색 api사용하는함수로 작성하자
    func search(term : String){
        //TODO : 마커를 중심으로 radius, sort 옵션을 추가하여 검색 api를 사용해 검색하기
        markerViewModel.clearResultMarker()
        for location in selectedLocationViewModel.selectedLocation{
            SearchKeyWordInteratorImpl.search(term, option: nil ) { response in
                //response의 데이터로 서칭된 결과 저장
                for document in response.documents{
                    let marker = NMFMarker(position: NMGLatLng(lat: Double(document.y)!, lng: Double(document.x)!))
                    DispatchQueue.main.async {
                        marker.captionText = document.place_name
                        marker.iconImage = NMFOverlayImage(name: "image1")
                        marker.isHideCollidedSymbols = true //캡션, 심벌이 충돌시 심벌 숨김
                        marker.touchHandler = { [weak self] (overlay : NMFOverlay) -> Bool in
                                //TODO : 인포윈도우로 정보 표현하기
                            print("marker data--> \(document)")
                                return true
                        }//handler
                        marker.mapView = self.mapView
                    } // main thread
                    self.markerViewModel.addResultMarker(marker: Marker(marker: marker, document: document))
                }//inner for
            }//closer
        } //for
    }//search
    
    func nearbySearch(term : String,option : Option){
        refreshMarker()
        SearchKeyWordInteratorImpl.search(term, option: option) { response in
            for document in response.documents{
                let marker = NMFMarker(position: NMGLatLng(lat: Double(document.y)!, lng: Double(document.x)!))
                DispatchQueue.main.async {
                    marker.captionText = document.place_name
                    marker.iconImage = NMFOverlayImage(name: "image1")
                    marker.isHideCollidedSymbols = true //캡션, 심벌이 충돌시 심벌 숨김
                    marker.touchHandler = { [weak self] (overlay : NMFOverlay) -> Bool in
                            //TODO : 인포윈도우로 정보 표현하기
                        print("marker data--> \(document)")
                        return true
                    }//handler
                    marker.mapView = self.mapView
                } // main thread
                self.markerViewModel.addResultMarker(marker: Marker(marker: marker, document: document))
            } //for
        }//search
    }
    
    func refreshMarker(){
        for marker in markerViewModel.resultMarkers{
            marker.marker.mapView = nil
        }
        markerViewModel.clearResultMarker()
    }
    
    //MARK: -requestGPSPermission
    func requestGPSPermission() -> Bool {
          switch CLLocationManager.authorizationStatus() {
          case .authorizedAlways, .authorizedWhenInUse:
            print("GPS: 권한 있음")
            return true
          case .restricted, .notDetermined:
            print("GPS: 아직 선택하지 않음")
            return false
          case .denied:
              print("GPS: 권한 없음")
            return false
          default:
              print("GPS: Default")
            return false
        }
    }
    
}

