//
//  Exam+CoreDataProperties.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 19.11.21.
//
//

import Foundation
import CoreData


extension Exam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exam> {
        return NSFetchRequest<Exam>(entityName: "Exam")
    }

    @NSManaged public var title: String
    @NSManaged public var subject: String
    @NSManaged public var comment: String
    @NSManaged public var done: Bool
    @NSManaged public var due: Date
    @NSManaged public var id: UUID
    @NSManaged public var notification: Date
    @NSManaged public var notify: Bool
    @NSManaged public var state: String

}

extension Exam : Identifiable {

}
