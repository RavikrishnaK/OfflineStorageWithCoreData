//
//  SaveDataOffline.swift
//  OfflineStorageWithCoreData
//
//  Created by RaviKrishna on 19/07/24.
//

import Foundation
import CoreData

func saveDataOffline(requestedData: RequestedData, context: NSManagedObjectContext, completionHandler: @escaping (StatusOfData) -> Void) {
    
    // Here we need to get our entityName created by us in .xcdatamodeld file
    let ourEntity = Tasks(context: context)
    ourEntity.title = requestedData.attribute1
    ourEntity.subTitle = requestedData.attribute2
    do {
        try context.save()
        completionHandler(.dataSaved)
    }
    catch{
        print("Failed to save data: \(error.localizedDescription)")
        completionHandler(.failedToSaved)
    }
}

struct RequestedData {
    var attribute1: String
    var attribute2: String
}

enum StatusOfData {
    case dataSaved
    case failedToSaved
}
