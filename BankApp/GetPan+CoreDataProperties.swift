//
//  GetPan+CoreDataProperties.swift
//  BankApp
//
//  Created by Ilahe Samedova on 20.10.23.
//
//

import Foundation
import CoreData


extension GetPan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GetPan> {
        return NSFetchRequest<GetPan>(entityName: "GetPan")
    }

    @NSManaged public var pan: String?

}

extension GetPan : Identifiable {

}
