//
//  Record+CoreDataProperties.swift
//  testApp1
//
//  Created by Sergey Ivanov on 06.09.2021.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var image: Data?
    @NSManaged public var text: String?

}

extension Record : Identifiable {

}
