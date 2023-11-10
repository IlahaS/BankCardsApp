
import UIKit


class TransferController: UIViewController {
    
    @IBOutlet weak var selectedCard: UILabel!
    @IBOutlet weak var transferLabel: UITextField!
    var card: [Card]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transfer Page"
        selectedCard.text = "no card is selected"
    
    }
    
    @IBAction func selectButtonClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "PickerViewController") as! PickerViewController
        controller.delegate = self
        controller.selectedItem = { card in
            DispatchQueue.main.async {
                self.selectedCard.text = "selected: \(card)"
                print("pan:\(card)")
            }
        }
        
        navigationController?.show(controller, sender: nil)
    }
    
    
}

extension TransferController: CardDelegate{
    func card(card: [Card]){
        if let selectedCard = card.first {
            self.selectedCard.text = "Selected Card: \(String(describing: selectedCard.cardNum))"
                }
    }
}

