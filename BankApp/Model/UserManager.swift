

import Foundation

class UserManager{
    
    static let shared = UserManager()
    var currentUser: User?
    private init() { }
    
}
struct User: Codable{
    
    var fullname: String?
    var email: String?
    var phone: Int?
    var password: String?
    var cards: [Card]
}

