import UIKit

class SportsTableViewController: UITableViewController {
    
    var legTitles: [String] = []
    var legImg: [Any] = []
    var legCountry: [String] = []
    var legKey: [Int] = []
    var data: [[String: Any]] = []
    var comeFrom : Int = 0

    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        switch comeFrom {
            
        case 0 :
            self.title = "Football leagues"
            fetchData(apiLink: sportsApi.Football.rawValue)
        case 1:
            self.title = "Basketball leagues"
            fetchData(apiLink: sportsApi.Basketball.rawValue)
        default:
            break
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! TableViewCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.legLabel.text = legTitles[indexPath.row]
       
        switch comeFrom {
            
        case 0 :
            var str = legImg[indexPath.row]
            let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".png")
            let result = predicate.evaluate(with: str)
            
            //MARK: - kingfisher
            if result{
                let url = URL(string: str as! String)
                cell.legImage.kf.setImage(with: url)
                
            }else{
                cell.legImage.image = UIImage(named: "footballicon")
            }
        case 1 :
            cell.legImage.image = UIImage(named: "basketballicon")
  
        default:
            break
        }
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let main = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        switch comeFrom {
            
        case 0 :
            main.index = 0
            main.legKey = legKey[indexPath.row]
        case 1:
            main.index = 1
            main.legKey = legKey[indexPath.row]

        default:
            break
        }
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    
    
}
