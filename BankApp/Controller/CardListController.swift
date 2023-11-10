

import UIKit

class CardListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var table: UITableView!
    
    let fileManager = FileManager()
    
    var card = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "LabelCell")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return card.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelCell
//        if CardsManager.shared.currentCard.count == 0 {
//            cell.titleLabel.text = "No cards here"
        //} else{
        cell.titleLabel.text = card[indexPath.row].cardNum
        

        return cell
    }
    
    @IBAction func plusClicked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CardsAddController") as! CardsAddController
        vc.delegate = self
        vc.didButtonClicked = { pan in
        }
        navigationController?.show(vc, sender: nil)
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(identifier: "CardListController") as! CardListController
//

}


extension CardListController: Carddelegate {
    func card(card: [Card]) {
        self.card = card
        table.reloadData()
    }
}
