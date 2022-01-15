//
//  Schedule+CoreDataProperties.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 08.12.21.
//
//

import Foundation
import CoreData


extension Appointment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Appointment> {
        return NSFetchRequest<Appointment>(entityName: "Appointment")
    }

    @NSManaged public var title: String
    @NSManaged public var start: Date
    @NSManaged public var end: Date
    @NSManaged public var day: String
    @NSManaged public var type: String

}

extension Appointment : Identifiable {

}
