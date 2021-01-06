////
////  LandMarkListViewController.swift
////  SoongMap_1
////
////  Created by 이숭인 on 2021/01/04.
////
//
//import UIKit
//import NMapsMap
//
//class LandMarkListViewController: UIViewController {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    private var landMarkList : [String] = ["카페","편의점","맛집","주유소","은행"]
//    private let selectedLocationViewModel = SelectedLocationViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.backgroundColor = UIColor.clear
//    }
//}
//
//extension LandMarkListViewController : UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //TODO : 선택된 셀을 기준으로 많이 사용하는 키워드로 검색기능 하면됨
//        //옵션 기능 또 넣어서 main에서는 search로 다시 넣으면 되징
//    }
//}
//
//extension LandMarkListViewController : UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return landMarkList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "landMarkCell", for: indexPath) as? LandMarkCell else {
//            return UICollectionViewCell()
//        }
//
//        switch indexPath.row {
//        case 0:
//            cell.imageView.image = UIImage(named: "cafe")
//            cell.label.text = landMarkList[indexPath.row]
//        case 1:
//            cell.imageView.image = UIImage(named: "convenience")
//            cell.label.text = landMarkList[indexPath.row]
//        case 2:
//            cell.imageView.image = UIImage(named: "restaurant")
//            cell.label.text = landMarkList[indexPath.row]
//        case 3:
//            cell.imageView.image = UIImage(named: "gas_station")
//            cell.label.text = landMarkList[indexPath.row]
//        default:
//            cell.imageView.image = UIImage(named: "bank")
//            cell.label.text = landMarkList[indexPath.row]
//        }
//
//        cell.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        cell.layer.cornerRadius = 20
//        cell.layer.masksToBounds = true
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0.3, height: 1.0)
//        cell.layer.shadowRadius = 2.0
//        cell.layer.shadowOpacity = 0.4
//        cell.layer.masksToBounds = false
//        return cell
//    }
//}
//
//extension LandMarkListViewController : UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 120, height: 40)
//    }
//}
//
//
