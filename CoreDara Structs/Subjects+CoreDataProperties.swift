//
//  Subjects+CoreDataProperties.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 08.12.21.
//
//

import Foundation
import CoreData


extension Subjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subjects> {
        return NSFetchRequest<Subjects>(entityName: "Subjects")
    }

    @NSManaged public var title: String

}

extension Subjects : Identifiable {

}
