//
//  episodesViewController.swift
//  ricknmorty
//
//  Created by Harsh  on 15/07/21.
//

import UIKit

class episodesViewController: UIViewController, UISearchBarDelegate, EpisodeManagerDelegate{
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var episodeManager = EpisodeManager()
    var episodeDetails=[EpisodeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeManager.delegate = self
        tableView.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "b", style: .plain, target: nil, action: nil)
    }
    
    func searchBarPressed(_ searchBar: UISearchBar){
        if  let episodeNo = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            EpisodeManager().getDetailsOfEpisodes(episodeNo)
        }
    }
    
    func didUpdateEpisode(_ episodeManager: EpisodeManager, _ seasons: [EpisodeData]) {
        episodeDetails = seasons
    }
    
    func didEncounterError(_ error: Error) {
        print(error)
    }
    
    
}

//MARK:- TableView

extension episodesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! episodesTableViewCell
        cell.seasonLabel.text = "Season \(indexPath.row+1)"
//         cell.collectionView(UICollectionView, cellForItemAt: indexPath)
        return cell
}
}

//let seasons = ["Season 1", "Season 2", "Season 3", "Season 4" ]
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300 //random height
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return seasons[section]
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = UIColor .clear //colour of section
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! episodesTableViewCell
//        return cell
//    }
