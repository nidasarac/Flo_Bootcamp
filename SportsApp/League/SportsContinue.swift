

import Foundation

extension SportsTableViewController {
    
    func fetchData(apiLink : String) {
        guard let url = URL(string: "\(apiLink)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let result = (json as? [String: Any])?["result"] as? [[String: Any]] {
                    self.data = result
                    self.legTitles = result.compactMap { $0["league_name"] as? String }
                    self.legCountry = result.compactMap { $0["country_name"] as? String }
                    self.legImg = result.compactMap { $0["league_logo"] as? Any }
                    self.legKey = result.compactMap { $0["league_key"] as? Int }
                    
                    self.legImg = self.legImg.map{$0 is NSNull ? "https://goplexe.org/wp-content/uploads/2023/07/placeholder-1.png" : $0}
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
        
    enum sportsApi : String {
        
        case Football = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366"
        case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=71c7d3089c0af637e5d191ad66c65f9a71004190fa872e48d8ed04fe8827e366"
        
    }
    
}
