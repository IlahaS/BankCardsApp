

import UIKit

//logout edilende root controller deyishilir, userdefaults silinir

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var user: User?
    
    var buttons: [String] = ["Cards", "Transfer", "Profile"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FileManagerHelper().readData { users in
            let phone = UserDefaults.standard.integer(forKey: "phone")
            user = users.first(where: { $0.phone == phone})

        }
        
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelCell
        cell.titleLabel.text = buttons[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0: // Cards
            let cardsVC = storyboard?.instantiateViewController(withIdentifier: "CardListController") as! CardListController
            cardsVC.modalPresentationStyle = .fullScreen
            cardsVC.card = user?.cards ?? []
            navigationController?.show(cardsVC, sender: nil)
        case 1: // Transfer
            
            let transferVC = storyboard?.instantiateViewController(withIdentifier: "TransferController") as! TransferController
            transferVC.modalPresentationStyle = .fullScreen
            navigationController?.show(transferVC, sender: nil)
        case 2: // Profile
            
            let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            profileVC.modalPresentationStyle = .fullScreen
            navigationController?.show(profileVC, sender: nil)
        default:
            break
        }
    }

}
