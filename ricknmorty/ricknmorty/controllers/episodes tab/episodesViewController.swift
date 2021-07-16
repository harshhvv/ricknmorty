//
//  episodesViewController.swift
//  ricknmorty
//
//  Created by Harsh  on 15/07/21.
//

import UIKit

class episodesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let url:String = "https://rickandmortyapi.com/api/episode"
    let seasons = ["Season 1", "Season 2", "Season 3", "Season 4" ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 //random height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return seasons[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor .clear //colour of section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! episodesTableViewCell
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
