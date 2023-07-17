

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var teamImage: UIImageView!
    
    func setupCellforteams(photo:UIImage){
        teamImage.image = photo
    }
}
