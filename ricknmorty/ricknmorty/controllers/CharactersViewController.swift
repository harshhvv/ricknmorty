//
//  EpisodesViewController.swift
//  ricknmorty
//
//  Created by Harsh  on 06/07/21.
//
import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate{
    
    
    let url = "https://rickandmortyapi.com/api/character/?name"
    var searchQuery = ""
    var url2 = ""
    var chars = [CharacterData]()
    var rowss:Int = 0
    var statuss:String = ""
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson(url: url)
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        url2 = "https://rickandmortyapi.com/api/character/?name=\(searchQuery)"
                downloadJson(url: url2)
              tableView.reloadData()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchQuery = searchTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        url2 = "https://rickandmortyapi.com/api/character/?name=\(searchQuery)"
                downloadJson(url: url2)
              tableView.reloadData()
    }
    
    func downloadJson(url:String) {
        
            if searchQuery != "" {
                if let url = URL(string: url2){
                    let session = URLSession.shared
                    
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if error != nil{
                            let alert = UIAlertController(title: "Oops...", message: "Incorrect name enterred", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
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
                            print(self.chars[0].results[0].image)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moreInfo", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowss
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Character
        cell.characterName.text = chars[0].results[indexPath.row].name
        cell.serialNumber.text = String(chars[0].results[indexPath.row].id)
        //print(indexPath)
        
        if let imageURL = URL(string: chars[0].results[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.characterDp.image = image
                        if self.statuss == "Alive"{
                            cell.characterDp.layer.borderColor = UIColor.cyan.cgColor
                        }
                        else if self.statuss == "Dead"{
                            cell.characterDp.layer.borderColor = UIColor.red.cgColor
                        }
                        //self.tableView.reloadData()
                    }
                }
            }
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        }
    }
    
    
    
    
}
