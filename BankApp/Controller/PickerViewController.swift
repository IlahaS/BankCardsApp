
import UIKit

protocol CardDelegate {
    func card(card: [Card])
}

class PickerViewController: UIViewController {

    @IBOutlet weak var selectedCard: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var cards = [Card]()
    var selection: String?
    var selectedItem : ((String) -> Void)?
    let fileManager = FileManagerHelper()
    var delegate: CardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        fileManager.readData { users in
            let users = users
            if let currentUserIndex = users.firstIndex(where: { $0.phone == UserDefaults.standard.integer(forKey: "phone") }) {
                cards = users[currentUserIndex].cards
                delegate?.card(card: users[currentUserIndex].cards)
                
//                DispatchQueue.main.async {
//                    UserManager.shared.currentUser?.cards.append(card)
                }
        }
        print(cards)
        
    }
  
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        _ = storyboard?.instantiateViewController(identifier: "TransferController") as! TransferController
        
        selectedItem?(selection ?? "")
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension PickerViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cards.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cards[row].cardNum
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = cards[row].cardNum
        selectedCard.text = "You selected : " + (selection ?? "")
        //global.pickerVar = selection ?? ""
    }
    
    
}
