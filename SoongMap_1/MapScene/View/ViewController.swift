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
    @IBOutlet weak var naverMapView : NMFNaverMapView!
    var mapView : NMFMapView {
        return naverMapView.mapView
    }
   
    var locationManager : CLLocationManager!
    let selectedLocationViewModel = SelectedLocationViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        dummySearchBar.delegate = self
        //Setting
        naverMapView.showLocationButton = true //내 위치 찾기 버튼 활성화 false는 비활성화
        setLocationOverlay() // locationOverlay setting
        mapView.touchDelegate = self
        
        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_LOCATION))
    }
}

//MARK: - Map Touch Delegate
extension ViewController : NMFMapViewTouchDelegate{
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        selectDesination(latlng)
        for pickable in mapView.pickAll(point, withTolerance: 250) {
            if let symbol = pickable as? NMFSymbol {
                
            } else if let marker = pickable as? NMFMarker {
                print("marker -> \(marker.captionText)")
            } else {
                print("overlay \n")
            }
        }
    }
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        //true ->  didTapMap 호출 (이벤트 전파)   ,  false -> didTapMap 호출하지 않음 (이벤트 소비)
        print("symvol : \(symbol.caption), \(symbol.position.lat) , \(symbol.position.lng), ")
        return true
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searching화면으로 전환
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "testVC") else{
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController {
    //TODO[x] : 선택한 위치에 서클 오버레이를 그리고 그 해당 좌표점을 selectedLocation에 저장
    //TODO : 이미 존재하는 오버레이 터치 시 오버레이 지우고 deleteSelectedLocation하기
    func selectDesination(_ latlng : NMGLatLng){
        var circleOverlay = NMFCircleOverlay(NMGLatLng(lat: latlng.lat, lng: latlng.lng), radius: 500) //radius는 일단 defalut, 커스텀설정은 나중에
        circleOverlay.fillColor =  #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).withAlphaComponent(31/255)
        circleOverlay.outlineWidth = 1
        circleOverlay.mapView = mapView
        circleOverlay.touchHandler = { [weak self] (overlay : NMFOverlay) in
            self?.selectedLocationViewModel.deleteLocation(latlng: latlng)
            circleOverlay.mapView = nil
            return true
        }
        //터치 핸들러에 들어가면 해당 코드는 작동하지 않음
        selectedLocationViewModel.addLocation(latlng: latlng, overlayID: circleOverlay.overlayID, radius: 500)
    }
    
    func setLocationOverlay(){
        let locationOverlay = mapView.locationOverlay
        locationOverlay.hidden = false
        locationOverlay.iconWidth = 100
        locationOverlay.iconHeight = 100
        locationOverlay.minZoom = 10
        locationOverlay.maxZoom = 20
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



//    // 내 위치 찾기 방법 이건 주석처리
//    func locationManagerSetting(){
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//
//        let coor = locationManager.location?.coordinate
//        latitude = coor?.latitude
//        longitude = coor?.longitude
//    }


