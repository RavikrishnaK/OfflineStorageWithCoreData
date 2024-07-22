//
//  Tasks+CoreDataProperties.swift
//  OfflineStorageWithCoreData
//
//  Created by RaviKrishna on 11/07/24.
//
//

import Foundation
import CoreData

// This class is created by me (For create this class, select your entityname on .xcdatamodeld file and choose editor on top and click on create NamanagedObject subclass  )
extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var title: String?
    @NSManaged public var subTitle: String?

}

extension Tasks : Identifiable {

}
