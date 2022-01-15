//
//  Grade+CoreDataProperties.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 19.11.21.
//
//

import Foundation
import CoreData


extension Grade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grade> {
        return NSFetchRequest<Grade>(entityName: "Grade")
    }

    @NSManaged public var title: String

}

extension Grade : Identifiable {

}
