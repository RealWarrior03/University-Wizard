//
//  Homework+CoreDataProperties.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 19.11.21.
//
//

import Foundation
import CoreData


extension Homework {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Homework> {
        return NSFetchRequest<Homework>(entityName: "Homework")
    }

    @NSManaged public var done: Bool
    @NSManaged public var due: Date
    @NSManaged public var subject: String
    @NSManaged public var title: String
    @NSManaged public var comment: String
    @NSManaged public var notification: Date
    @NSManaged public var notify: Bool

}

extension Homework : Identifiable {

}
