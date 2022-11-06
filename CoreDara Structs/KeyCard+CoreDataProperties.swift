//
//  KeyCard+CoreDataProperties.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 19.11.21.
//
//

import Foundation
import CoreData


extension KeyCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KeyCard> {
        return NSFetchRequest<KeyCard>(entityName: "KeyCard")
    }

    @NSManaged public var title: String

}

extension KeyCard : Identifiable {

}
