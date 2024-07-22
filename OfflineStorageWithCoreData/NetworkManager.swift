//
//  NetworkManager.swift
//  OfflineStorageWithCoreData
//
//  Created by RaviKrishna on 19/07/24.
//

import Foundation
import CoreData
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func uploadRequiredInfo(offlineData data:[Tasks], completionHandler: @escaping (Result<Void, Error>) -> Void) {
        // Here we should change url as per our requirement
        guard let url = URL(string: "https://yourserver.com/upload") else {
            completionHandler(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            let encodedJsonData = try JSONEncoder().encode(data)
            urlRequest.httpBody = encodedJsonData
        }
        catch {
            completionHandler(.failure(error))
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
                return
            }
            completionHandler(.success(()))
        }.resume()
    }
}

// Kittu
class GetPersistentContext {
    static let shared = GetPersistentContext()
    var context: NSManagedObjectContext?
    
    private init() {
        DispatchQueue.main.async {
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            self.context = appdelegate.persistentContainer.viewContext
        }
    }
}
