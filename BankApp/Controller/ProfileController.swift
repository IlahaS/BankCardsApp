

import UIKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    let manager = FileManagerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
         
        let defaults = UserDefaults.standard
        if let email = defaults.string(forKey: "email"),
            let fullname = defaults.string(forKey: "fullName"),
            let phone = defaults.string(forKey: "phone"){
                    switch indexPath.row {
                    case 0:
                        cell.info.text = fullname
                    case 1:
                        cell.info.text = email
                    case 2:
                        cell.info.text = phone
                    case 3:
                       
                        break
                    default:
                        break
                    }
                } else {
                    cell.info.text = "No user logged in"
                }
                
                return cell
            }

    @IBAction func logOutButtonClicked(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "loggedIn")
        
        manager.writeData(users: [])
        
        UserDefaults.standard.synchronize()
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "LoginController") as? LoginController {
           
            self.view.window?.rootViewController = UINavigationController(rootViewController: controller)
        }
        
    }
}
