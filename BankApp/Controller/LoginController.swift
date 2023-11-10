

import UIKit
import Lottie

class LoginController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var animationImage: LottieAnimationView!
    
    let fileManager = FileManagerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login()
        errorLabel.isHidden = true
        password.isSecureTextEntry = true
        animationImage.play()
        
    }
    
    func login(){
        
        UserDefaults.standard.setValue(true, forKey: "loggedIn")
    }
    //
    @IBAction func loginButton(_ sender: Any) {
        
        checkValidation()
    }
    
    func addInfo(user: User) {
        email.text = user.email
        password.text = user.password
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        controller.modalPresentationStyle = .fullScreen
        controller.onLogin = { email, password in
            self.email.text = email
            self.password.text = password
        }
        //controller.delegate2 = self
        navigationController?.show(controller, sender: nil)
        
    }
    
    func checkValidation() {
        
        //        guard let currentUser = UserManager.shared.currentUser else {
        //                    errorLabel.isHidden = false
        //                    errorLabel.text = "No user logged in"
        //                    return
        //                }
        
        fileManager.readData { users in
            
            if users.contains(where: { $0.email == email.text && $0.password == password.text}) {
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
                navigationController?.show(vc, sender: nil)
            }
            else{
                if email.text == "" || password.text == "" || email.text == "" && password.text == ""{
                    errorLabel.isHidden = false
                    errorLabel.text = "Enter something!"
                } else if !isValidEmail(email: email.text!){
                    errorLabel.isHidden = false
                    errorLabel.text = "Invalid email format!"
                } else if email.text != UserManager.shared.currentUser?.email{
                    errorLabel.isHidden = false
                    errorLabel.text = "Wrong email!"
                } else if password.text?.count ?? 0 < 5 || password.text?.count ?? 0 > 10{
                    errorLabel.isHidden = false
                    errorLabel.text = "Wrong password format!"
                } else if password.text != UserManager.shared.currentUser?.password {
                    errorLabel.isHidden = false
                    errorLabel.text = "Wrong password!"
                }
            }
        }
    }
    
    
    func isValidEmail( email: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: UserManager.shared.currentUser)
    }
    
}
