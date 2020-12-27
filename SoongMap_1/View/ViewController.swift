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
    
    @IBOutlet weak var naverMap: NMFNaverMapView!
    var mapView : NMFMapView {
        return naverMap.mapView
    }
   
    var locationManager : CLLocationManager!
    
    let myLocationViewModel = MyLocationViewModel()
    let selectedLocationViewModel = SelectedLocationViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naverMap.showLocationButton = true //내 위치 찾기 버튼 활성화 false는 비활성화
        setLocationOverlay() // locationOverlay setting
        
        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_LOCATION))
    }
    
   
}

extension ViewController {
    
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
    func setLocationOverlay(){
        let locationOverlay = mapView.locationOverlay
        locationOverlay.hidden = false
        locationOverlay.iconWidth = 100
        locationOverlay.iconHeight = 100
        locationOverlay.minZoom = 10
        locationOverlay.maxZoom = 20
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
}



