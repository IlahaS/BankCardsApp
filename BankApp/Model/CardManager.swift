//
//  CardManager.swift
//  BankApp
//
//  Created by Ilahe Samedova on 15.10.23.
//

import Foundation

//class CardsManager{
//    static let shared = CardsManager()
//    var currentCard = [Card]() {
//       
//    }
//    
//    private init() {
//       
//    }
//}

struct Card: Codable{
    var cardNum: String?
    var cvv: String?
    var date: String?
}
