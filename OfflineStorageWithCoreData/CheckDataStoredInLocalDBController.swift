//
//  CheckDataStoredInLocalDBController.swift
//  OfflineStorageWithCoreData
//
//  Created by RaviKrishna on 19/07/24.
//

import Foundation
import UIKit

class CheckDataStoredInLocalDBController: UIViewController {
    

    let context = GetPersistentContext.shared.context

    @IBOutlet weak var fld1: UITextField!
    @IBOutlet weak var fld2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let context = context else {return}

        guard let field1 = self.fld1.text, let field2 = self.fld2.text else { return }
        let dataFromFields = RequestedData(attribute1: field1, attribute2: field2)
        saveDataOffline(requestedData: dataFromFields, context: context) { status in
            switch status {
            case .dataSaved:
                print("Data succussfully saved in local DB.")
                self.navigationController?.popToRootViewController(animated: true)
            case .failedToSaved:
                print("Failed to add task")
            }
        }
    }
}
