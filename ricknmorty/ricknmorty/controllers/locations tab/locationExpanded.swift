//
//  locationExpanded.swift
//  ricknmorty
//
//  Created by Harsh  on 19/07/21.
//

import UIKit

class locationExpanded: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var residents:[String]?
    var locationName:String?
    var locationType:String?
    var segmentedIndex:Int?
    var residentInfo = [CharacterData]()
    
    //var locImage:UIImage?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var locIMG: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        locIMG.layer.masksToBounds = false
        locIMG.layer.cornerRadius = locIMG.frame.height/2
        locIMG.clipsToBounds = true
        locationNameLabel.text = locationName
        locationTypeLabel.text = locationType
        switch segmentedIndex {
        case 0:
            locIMG.image = #imageLiteral(resourceName: "spaceStationIcon")
        case 1:
            locIMG.image = #imageLiteral(resourceName: "dimesnionIcon")
        case 2:
            locIMG.image = #imageLiteral(resourceName: "planetIcon")
        default:
            break
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return residents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        return collectionCell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      return 1
    }
    
}
