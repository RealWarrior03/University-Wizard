//
//  Categories+CoreDataProperties.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 26.09.22.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var name: String
    @NSManaged public var color: String
    @NSManaged public var id: UUID

}

extension Categories : Identifiable {

}
