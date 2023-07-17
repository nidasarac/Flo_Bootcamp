

import UIKit
import Alamofire

class MainViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var TeamsLabel: UILabel!
    
    @IBOutlet weak var teamsCell: UICollectionView!
    
    @IBOutlet weak var upComingCell: UICollectionView!
    
    @IBOutlet weak var latestResultsCell: UICollectionView!
    
    
    
    var index : Int = 0
    var legKey : Int = 0
    var dataDetails : DetailsResponse?
    var sportType = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        teamsCell.dataSource = self
        teamsCell.delegate = self
        
        switch index {
            
        case 0 :
            let footBallApi = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366&from=2023-04-19&to=2024-02-28&leagueId=\(legKey)"
            fetchData(apiLink: footBallApi) { res in
                print("Football")
            }
        case 1:
            let BasketBallApi = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366&from=2022-12-13&to=2023-02-20&leagueId=\(legKey)"
            fetchData(apiLink: BasketBallApi) { res in
                print("Basketball")
            }
     
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // number of items for teams
        if collectionView == teamsCell {
            print(dataDetails?.result.count ?? 1)
            return dataDetails?.result.count ?? 1
        }
        // number of items for upComing Event
        if collectionView == upComingCell {
            return dataDetails?.result.count ?? 0
            //            return homeTeam.count
        }
        // number of items for latest Result
        return dataDetails?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // cofiguration cell for Teams
        if collectionView == teamsCell {
            
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsCollectionViewCell
            //            cell.backgroundColor = UIColor.red
            
            let team = dataDetails?.result[indexPath.row]
            
            switch index {
                
            case 0:
                let url = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2023/07/placeholder-1.png")
                cell.teamImage.kf.setImage(with: url)
                
            case 1 , 2:
                let url = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.teamImage.kf.setImage(with: url)
                
   
                
            default:
                break
            }
               
            return cell
        }
        
        if collectionView == upComingCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComing", for: indexPath) as! UpComingCollectionViewCell
            let team = dataDetails?.result[indexPath.row]
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.borderWidth = 0.5
            switch index {
            case 0 :
                cell.configureCell(homeTitle: (team?.event_away_team)! , awayTitle: (team?.event_home_team)!, eventDate: (team?.event_date)! , homeLogo: (team?.home_team_logo)!, awaylogo: (team?.away_team_logo)!, eventTime:(team?.event_time)!)
           case 1 :
                let urlHome = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2023/07/placeholder-1.png")
                let urlAway = URL(string: (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2023/07/placeholder-1.png")
                cell.configureCell(homeTitle: (team?.event_home_team)!, awayTitle: (team?.event_away_team)!, eventDate: (team?.event_date)! , homeLogo:"" , awaylogo: "", eventTime: (team?.event_time)!)
                cell.homeTeamImageView.kf.setImage(with: urlHome)
                cell.awayTeamImageView.kf.setImage(with: urlAway)
                
                
            default :
                break
            }
            return cell
        }
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResults", for: indexPath) as! LatestResultsCollectionViewCell
        let team = dataDetails?.result[indexPath.row + 20 ]
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.3

        
        switch index {
        case 0:
            cell.homeTeamLabel.text = team?.event_away_team
            cell.awayTeamLabel.text = team?.event_home_team
            
            let urlHome = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2023/04/placeholder-1.png")
            cell.homeTeamImageView.kf.setImage(with: urlHome)
            let urlAway = URL(string: (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2023/04/placeholder-1.png")
            cell.awayTeamImageView.kf.setImage(with: urlAway)
            
            cell.eventDateLabel.text = team?.event_date
            cell.eventTimeLabel.text = team?.event_time
            cell.eventFinalResultLabel.text = team?.event_final_result
            
        case 1:
            cell.homeTeamLabel.text = team?.event_home_team
            cell.awayTeamLabel.text = team?.event_away_team
            
            let urlHome = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.homeTeamImageView.kf.setImage(with: urlHome)
            let urlAway = URL(string: (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.awayTeamImageView.kf.setImage(with: urlAway)
            
            cell.eventDateLabel.text = team?.event_date
            cell.eventTimeLabel.text = team?.event_time
            cell.eventFinalResultLabel.text = team?.event_final_result
            
        
        default:
            break
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upComingCell{
            return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
        }
        if collectionView == teamsCell{
            return CGSize(width: 150, height: 150)
        }
        return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == upComingCell{
            return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
        }
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}


