//
//  ConnectivityMonitor.swift
//  OfflineStorageWithCoreData
//
//  Created by RaviKrishna on 16/07/24.
//

import Foundation
import CoreData
import UIKit
import Network
 
class ConnectivityMonitor {
    private let netWorkMonitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    init() {
        netWorkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Network Available")
                self.syncDataIfNeeded()
            }
            else {
                print("No Network")
            }
        }
        netWorkMonitor.start(queue: queue)
    }
    
    private func syncDataIfNeeded() {
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        guard let context = GetPersistentContext.shared.context else {return}

        do {
            let fetchdOfflineData = try context.fetch(fetchRequest)
            NetworkManager.shared.uploadRequiredInfo(offlineData: fetchdOfflineData) { result in
                switch result {
                case .success:
                    print("Data synchronized successfully")
                    for item in fetchdOfflineData {
                        context.delete(item)
                    }
                    try? context.save()
                case .failure(let error):
                    print("Failed to upload data: \(error.localizedDescription)")
                }
            }
        }
        catch{
            print("Failed to fetch offline data: \(error.localizedDescription)")
        }
    }
}
