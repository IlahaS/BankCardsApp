
import UIKit


protocol Carddelegate{
    func card(card: [Card])
}

class CardsAddController: UIViewController {
    
    @IBOutlet weak var expDate: UITextField!
    @IBOutlet weak var panNum: UITextField!
    @IBOutlet weak var cvv: UITextField!
    
    let fileManager = FileManagerHelper()
    
    var delegate: Carddelegate?
    var didButtonClicked: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Card Details"
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
        didButtonClicked?(panNum.text ?? "")
        
        fileManager.readData { users in
            var users = users
            let card = Card(cardNum: panNum.text, cvv: cvv.text, date: expDate.text)
            
            if let currentUserIndex = users.firstIndex(where: { $0.phone == UserDefaults.standard.integer(forKey: "phone") }) {
                
                users[currentUserIndex].cards.append(card)
                delegate?.card(card: users[currentUserIndex].cards)
                
//                DispatchQueue.main.async {
//                    UserManager.shared.currentUser?.cards.append(card)
//                }
                
                fileManager.saveData(users: users) { success in
                    if success {
                        print("User data updated and saved successfully")
                    } else {
                        print("Failed to save user data")
                    }
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
}
