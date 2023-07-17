

import UIKit

class FavoriteTeamCell: UITableViewCell {
    @IBOutlet weak var FavoriteTeamView: UIView!
    
    @IBOutlet weak var FavoriteTeamImage: UIImageView!
    
    @IBOutlet weak var FavoriteTeamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



