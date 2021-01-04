//
//  LandMarkListViewController.swift
//  SoongMap_1
//
//  Created by 이숭인 on 2021/01/04.
//

import UIKit

class LandMarkListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.clear
    }
}

extension LandMarkListViewController : UICollectionViewDelegate {
    
}

extension LandMarkListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "landMarkCell", for: indexPath) as? LandMarkCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        return cell
    }
}

//extension LandMarkListViewController : UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 120, height: 50)
//    }
//}


