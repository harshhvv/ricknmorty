//
//  locationsViewController.swift
//  ricknmorty
//
//  Created by Harsh  on 15/07/21.
//

import UIKit

class locationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var locs = [LocationData]()
//    var locs2 = [LocationData]()
//    var locs3 = [LocationData]()
    var searchQuery = ""
    var url2 = ""
    var defUrl = ""
    var numberOfRows:Int = 0
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        downloadJson()
    }
    

    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl)
    {
        downloadJson()
    }
    
    //MARK: search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        switch segmented.selectedSegmentIndex {
        case 0:
            url2 = "https://rickandmortyapi.com/api/location/?type=station&name=\(searchQuery)"
            //break
        case 1:
            url2 = "https://rickandmortyapi.com/api/location/?type=dimension&name=\(searchQuery)"
            //break
        case 2:
            url2 = "https://rickandmortyapi.com/api/location/?type=planet&name=\(searchQuery)"
            //break
        default:
            url2 = "https://rickandmortyapi.com/api/location/"
        }
        downloadJson()
        //tableView.reloadData()
        //print(url2)
    }
    
    
    //MARK: JSON
    func downloadJson() {
        
        switch segmented.selectedSegmentIndex {
        case 0:
            defUrl = "https://rickandmortyapi.com/api/location/?type=station"
            //break
        case 1:
            defUrl = "https://rickandmortyapi.com/api/location/?type=dimension"
            //break
        case 2:
            defUrl = "https://rickandmortyapi.com/api/location/?type=planet"
            //break
        default:
            break
        }
        
        if searchQuery != "" {
            if let url = URL(string: url2){
                let session = URLSession.shared
                
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    //print("no error")
                    do{
                        let decoder = JSONDecoder()
                        let downloadeData = try decoder.decode(LocationData.self, from: data!)
                        self.locs = [downloadeData]
                        //print(self.locs[0].results[0].id)
                        //print(self.locs[0].results[0].name)
                        self.numberOfRows = self.locs[0].results.count
                        //print(self.locs[0].results.count)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
                task.resume()
            }
        } else {
            if let url = URL(string: defUrl){
                let session = URLSession.shared
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    //no error
                    do{
                        let decoder = JSONDecoder()
                        let downloadeData = try decoder.decode(LocationData.self, from: data!)
                        self.locs = [downloadeData]
                        //print(self.locs)
                        self.numberOfRows = self.locs[0].results.count
                        //self.statuss = self.chars[0].results[0].status
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
                task.resume()
            }
        }
        
    }
    
    
    //MARK: table functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! locationsTableViewCell
        switch segmented.selectedSegmentIndex {
        case 0:
            cell.locImage.image = #imageLiteral(resourceName: "spaceStationIcon")
        case 1:
            cell.locImage.image = #imageLiteral(resourceName: "dimesnionIcon")
        case 2:
            cell.locImage.image = #imageLiteral(resourceName: "planetIcon")
        default:
            cell.locImage.image = #imageLiteral(resourceName: "BG-2")
        }
        
        cell.idLabel.text = String(indexPath.row+1)
        //cell.idLabel.text = String(self.locs[0].results[indexPath.row].id)
        cell.nameLabel.text = self.locs[0].results[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    
}
