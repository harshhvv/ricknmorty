//
//  EpisodesViewController.swift
//  ricknmorty
//
//  Created by Harsh  on 06/07/21.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let url = "https://rickandmortyapi.com/api/character/?name"
    var chars = [CharacterData]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson(url: url)
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        let url2 = "https://rickandmortyapi.com/api/character/?name\(String(describing: searchTF))"
        downloadJson(url: url2)
        tableView.reloadData()
    }
    
    func downloadJson(url:String) {
        if let url = URL(string: url){
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                print("no error")
                do{
                    let decoder = JSONDecoder()
                    let downloadeData = try decoder.decode(CharacterData.self, from: data!)
                    self.chars = [downloadeData]
                    //print(self.chars[0].results[0])
                    print(self.chars[0].results[0].name)
//                    print(self.chars[0].results.count)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Character
        cell.characterName.text = chars[0].results[indexPath.row].name
        cell.serialNumber.text = String(chars[0].results[indexPath.row].id)
        print(indexPath)

        if let imageURL = URL(string: chars[0].results[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.characterDp.image = image
                    }
                }
            }
        }
        return cell
    }
    
    
}
