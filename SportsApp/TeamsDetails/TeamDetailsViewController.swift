

import UIKit
import Alamofire
import CoreData

class TeamDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //variable to response data
    @IBOutlet weak var playersTable: UITableView!
    var dataTeam : TeamResponse?
    var playerData : TeamResponseNew?
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    var teamIndex = 0
    var sportType = ""
    var teamKey = ""
    var teeamImg = ""
    
    
    var favArray = [String]()
    
    var keyFav = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersTable.delegate = self
        playersTable.dataSource = self
        
        teamName.layer.cornerRadius = 20.0
        teamName.layer.borderWidth = 0.5
        teamName.layer.borderColor = UIColor.red.cgColor
        teamName.layer.backgroundColor = UIColor.cyan.cgColor
        
        fetchPlayerData {  result in
            DispatchQueue.main.async {
                self.playerData = result
                
                self.keyFav = "fav\(self.teamKey)"
                print(self.keyFav)
    
                if UserDefaults.standard.bool(forKey: self.keyFav){
                    self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    print("fav")
                }else if !(UserDefaults.standard.bool(forKey: self.keyFav)){
                    self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    
                    print("not fav")
                }
                
                self.playersTable.reloadData()
            }
        }
        fetchData { result in
            DispatchQueue.main.async {
                self.dataTeam = result
                
                self.teamName.text = self.dataTeam?.result[0].team_name
                
                let url = URL(string: self.dataTeam?.result[0].team_logo ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                self.teamImg.kf.setImage(with: url)
                
                print(self.dataTeam?.result[0].team_name ?? "dd")
                
                self.keyFav = "fav\(self.teamKey)"
                print(self.keyFav)
                
                if UserDefaults.standard.bool(forKey: self.keyFav) {
                    self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    print("fav")
                } else {
                    self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    print("not fav")
                }
            }
        }

        
        print(favArray)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        _ = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePlayer")
        
        request.predicate = NSPredicate(format: "name == %@", dataTeam?.result[0].team_name ?? "")
        
    }
    
    
    
    @IBAction func favButtonAction(_ sender: Any) {
       
        favoriteButtonTapped()
        
    }
    
    
}
//MARK: - fetch the data for teams

extension TeamDetailsViewController{
    func fetchData(compilation: @escaping (TeamResponse?) -> Void){
        let footUrl =  "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=\(teamKey)&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366"
       let basketUrl =  "https://apiv2.allsportsapi.com/basketball/?met=Teams&teamId=\(teamKey)&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366"
       
        
        switch teamIndex {
        case 0 :
            AF.request(footUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 1 :
            AF.request(basketUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        
        default:
            break
        }
    }
    
}

extension TeamDetailsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerData?.result[0].players.count ?? 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerscell", for: indexPath) as! playersTableViewCell
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        let player =  playerData?.result[0].players[indexPath.row]
        cell.playerName.text = player?.player_name ?? "Unknown"
        cell.playerNumber.text = player?.player_number ?? "Unknown"
        
        //MARK: - predicate
        let string = player?.player_image
        let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".jpg")
        let result = predicate.evaluate(with: string)
        //MARK: - kingfisher
        if result{
            let url = URL(string: (player?.player_image)!)
            cell.playerImg.kf.setImage(with: url)
        }else
        {
            switch teamIndex {
            case 0 :
                cell.playerImg.image = UIImage(named: "football")
            case 1 :
                cell.playerImg.image = UIImage(named: "NewBasketball")
            
            default:
                break
            }
        }
        //MARK: - make the cell look round
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension TeamDetailsViewController {
    
    func fetchPlayerData(compilation: @escaping (TeamResponseNew?) -> Void){
        let footUrl =  "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=\(teamKey)&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366"
        let basketUrl =  "https://apiv2.allsportsapi.com/basketball/?met=Teams&teamId=\(teamKey)&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366"
      
        
        
    https://apiv2.allsportsapi.com/tennis/?met=Players&playerId=785&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366
        
        switch teamIndex {
        case 0 :
            AF.request(footUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponseNew.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 1 :
            AF.request(basketUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponseNew.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        
        default:
            break
        }
    }
}

extension TeamDetailsViewController {
    
    
    @objc func favoriteButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if (favButton.configuration?.image == UIImage(systemName: "heart.fill")){
            self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            print("remove to fav")

            UserDefaults.standard.set(false, forKey: keyFav)
            
            // Remove the player name from favorites
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePlayer")
            
          
            request.predicate = NSPredicate(format: "name == %@", dataTeam?.result[0].team_name ?? "")
            
           
            
            request.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(request)
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
                try context.save()
            } catch {
                print("Error removing from favorites: \(error)")
            }
            
        } else if (favButton.configuration?.image == UIImage(systemName: "heart")){
            self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favArray.append(teamName.text!)
            print("add to fav")
            UserDefaults.standard.set(true, forKey: keyFav)
            // Add the player name to favorites
            let entity = NSEntityDescription.entity(forEntityName: "FavoritePlayer", in: context)!
            let favoritePlayer = NSManagedObject(entity: entity, insertInto: context)
            
            
            
            favoritePlayer.setValue(dataTeam?.result[0].team_name, forKey: "name")
            favoritePlayer.setValue(teamKey, forKey: "key")
            
            
            do {
                try context.save()
            
            } catch {
                print("Error adding to favorites: \(error)")
            }
            
        }
    }
    
}
