

import UIKit
import Lottie

//protocol AddInfoDelegate{
//    func addInfo(user: User)
//}

class RegisterController: UIViewController {
    
    @IBOutlet weak var fullnameReg: UITextField!
    @IBOutlet weak var emailReg: UITextField!
    @IBOutlet weak var passReg: UITextField!
    @IBOutlet weak var phoneNumReg: UITextField!
    
    //var delegate2: AddInfoDelegate?
    let helper = FileManagerHelper()
    var onUserRegistered: ((User) -> Void)?
    var onLogin: ((String?, String?) -> Void)?
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passReg.isSecureTextEntry = true
        
        helper.readData { users in
            self.users = users
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        
        onLogin?(emailReg.text, passReg.text)
        
        let user = User(fullname: fullnameReg.text ?? "",
                        email: emailReg.text ?? "",
                        phone: Int(phoneNumReg.text ?? "") ?? 0,
                        password: passReg.text ?? "", cards: [])
        
        onUserRegistered?(user)
        UserManager.shared.currentUser = user
        
        users.append(user)
        helper.writeData(users: self.users)
        //delegate2?.addInfo(user: user)
        
        let defaults = UserDefaults.standard
        
        defaults.set(fullnameReg.text, forKey: "fullName")
        defaults.set(emailReg.text, forKey: "email")
        defaults.set(phoneNumReg.text, forKey: "phone")
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
