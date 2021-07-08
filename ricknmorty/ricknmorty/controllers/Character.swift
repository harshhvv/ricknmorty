//
//  EpisodesCell.swift
//  ricknmorty
//
//  Created by Harsh  on 06/07/21.
//

import UIKit

class Character: UITableViewCell {

    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var characterDp: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
