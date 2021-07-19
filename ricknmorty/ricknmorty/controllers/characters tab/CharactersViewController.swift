//
//  EpisodesViewController.swift
//  ricknmorty
//
//  Created by Harsh  on 06/07/21.
//
import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate{
    
    //MARK:- Variables
    let url = "https://rickandmortyapi.com/api/character/?name"
    var searchQuery = ""
    var url2 = ""
    var chars = [CharacterData]()
    var rowss:Int = 0
    var statuss:String = ""
    var dp:UIImage?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson(url)
        searchBar.delegate = self
    }
    
    //MARK:- search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        url2 = "https://rickandmortyapi.com/api/character/?name=\(searchQuery)"
        downloadJson(url2)
        tableView.reloadData()
    }
    
    //MARK: JSON
    func downloadJson(_ url:String) {
        
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
                        let downloadeData = try decoder.decode(CharacterData.self, from: data!)
                        self.chars = [downloadeData]
                        self.rowss = self.chars[0].results.count
                        print(self.url2)
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
            if let url = URL(string: url){
                let session = URLSession.shared
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    //no error
                    do{
                        let decoder = JSONDecoder()
                        let downloadeData = try decoder.decode(CharacterData.self, from: data!)
                        self.chars = [downloadeData]
                        self.rowss = self.chars[0].results.count
                        self.statuss = self.chars[0].results[0].status
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moreInfo", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowss //got from api
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139 //got from figma
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Character
        cell.characterName.text = chars[0].results[indexPath.row].name
        cell.serialNumber.text = String(indexPath.row+1)
        
        if let imageURL = URL(string: chars[0].results[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.characterDp.image = image
                        self.dp = image
                        if self.statuss == "Alive"{
                            cell.characterDp.layer.borderColor = UIColor.cyan.cgColor
                        }
                        else{
                            cell.characterDp.layer.borderColor = UIColor.red.cgColor
                        }
                    }
                    
                }
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //passing values to next viewController: "moreInfoVC"
        if segue.destination is moreInfoVC{
            
            let vc = segue.destination as? moreInfoVC
            let indexPaths = self.tableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            
            vc?.name = chars[0].results[indexPath.row].name
            vc?.dpURL = chars[0].results[indexPath.row].image
            vc?.status = chars[0].results[indexPath.row].status
            vc?.species = chars[0].results[indexPath.row].species
            vc?.origin = chars[0].results[indexPath.row].origin.name
            vc?.gender = chars[0].results[indexPath.row].gender
            vc?.lastActive = chars[0].results[indexPath.row].location.name
            //vc?.moreInfoDp = dp
        }
    }
}
