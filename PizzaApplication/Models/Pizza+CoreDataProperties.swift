//
//  Pizza+CoreDataProperties.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/12/22.
//
//

import Foundation
import CoreData


extension Pizza {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pizza> {
        return NSFetchRequest<Pizza>(entityName: "Pizza")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var ingredients: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var image: Data?

}

extension Pizza : Identifiable {

}
