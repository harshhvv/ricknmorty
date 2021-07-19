//
//  
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
        characterDp.layer.masksToBounds = false
        characterDp.layer.cornerRadius = characterDp.frame.height/2
        //characterDp.layer.borderWidth = 4
        //characterDp.layer.borderColor = UIColor.clear.cgColor
        characterDp.clipsToBounds = true
        
    }

}
