//
//  episodesTableViewCell.swift
//  ricknmorty
//
//  Created by Harsh  on 16/07/21.
//

import UIKit

class episodesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var episodeManager = EpisodeManager()
    var episodeDetails=[EpisodeData]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        episodeManager.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11 //random number
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! episodesCollectionViewCell
//        print("\(indexPath.row)")
        collectionCell.dateLabel.text = episodeDetails[indexPath.row].results[indexPath.row].airDate
        collectionCell.nameLabel.text = "\(episodeDetails[indexPath.row].results[indexPath.row].episode.suffix(2)):\(episodeDetails[indexPath.row].results[indexPath.row].name)"
        collectionCell.episodeDp.image = UIImage(imageLiteralResourceName: "Image")
        return collectionCell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

//MARK:-EpisodeManagerDelegate
extension episodesTableViewCell:EpisodeManagerDelegate{
    func didUpdateEpisode(_ episodeManager: EpisodeManager, _ seasons: [EpisodeData]) {
        episodeDetails = seasons

    }
    
    func didEncounterError(_ error: Error) {
        print(error)
    }
    
}
