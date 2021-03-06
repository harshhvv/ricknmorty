//
//  moreInfoVC.swift
//  ricknmorty
//
//  Created by Harsh  on 08/07/21.
//

import UIKit

class moreInfoVC: UIViewController, UIViewControllerTransitioningDelegate  {
    var moreChars = [CharacterData]()
    
    var name = ""
    var dpURL = ""
    var species = ""
    var status = ""
    var origin = ""
    var gender = ""
    var lastActive = ""
    
    @IBOutlet weak var charDP: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    override func viewDidLoad() {
        view.backgroundColor = .clear
        //print("ok")
        nameLabel.text = name
        statsLabel.text = "\(species), \(status)"
        originLabel.text = origin
        genderLabel.text = gender
        locLabel.text = lastActive
        if let imageURL = URL(string: dpURL) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.charDP.image = image
                    }
                }
            }
        }
        charDP.layer.cornerRadius = 20
    }
   
}
