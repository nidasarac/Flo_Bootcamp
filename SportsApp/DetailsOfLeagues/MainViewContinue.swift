
import Foundation
import Alamofire
import UIKit


extension MainViewController {
    
    func fetchData(apiLink : String, compilation: @escaping (DetailsResponse?) -> Void)
    {
        AF.request(apiLink).response
        { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(DetailsResponse.self, from: data)
                    print(result.success!)
                    compilation(result)
                    DispatchQueue.main.async {
                        self.dataDetails = result
                        self.upComingCell.reloadData()
                        self.latestResultsCell.reloadData()
                        self.teamsCell.reloadData()
                    }
                }
                catch{
                    compilation(nil)
                }
            } else {
                compilation(nil)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCell {
                let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
                
                let team = dataDetails?.result[indexPath.row]
                let homeTeamImg = team?.home_team_logo ?? ""
                storyBoard.teeamImg = String(homeTeamImg)
                
                let homeTeamKey = team?.home_team_key ?? 0
                storyBoard.teamKey = String(homeTeamKey)
            
            
            switch index {
            case 0 :
                storyBoard.sportType = "football"
                storyBoard.teamIndex = 0
                
           case 1 :
                storyBoard.sportType = "basketball"
                storyBoard.teamIndex = 1
            
                
            default:
                break
            }
            self.navigationController?.pushViewController(storyBoard, animated: true)
        }
    }
    
    
}

enum upcomingApi : String {
    
    case Football = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366&from=2023-07-18&to=2023-07-18"
    case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366&from=2023-07-16&to=2023-07-16"
   
    
}













