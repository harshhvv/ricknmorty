//
//  locationsViewController.swift
//  ricknmorty
//
//  Created by Harsh  on 15/07/21.
//

import UIKit

class locationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        searchBar.delegate = self
    }
    
    @IBAction func segmentedControlActionChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    //MARK: search
    
    //MARK: JSON
    
    //MARK: table functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! locationsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //random
    }
    
}
