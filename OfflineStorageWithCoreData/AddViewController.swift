//
//  AddViewController.swift
//  OfflineStorageWithCoreData
//
//  Created by RaviKrishna on 10/07/24.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var subtitleTF: UITextField!
    
    let context = GetPersistentContext.shared.context

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        
        guard let context = context else {return}

        guard let title = self.titleTF.text, let subTitle = self.subtitleTF.text else { return }
        let dataFromFields = RequestedData(attribute1: title, attribute2: subTitle)
        saveDataOffline(requestedData: dataFromFields, context: context) { status in
            switch status {
            case .dataSaved:
                print("Data succussfully saved in local DB.")
                self.navigationController?.popViewController(animated: true)
            case .failedToSaved:
                print("Failed to add task")
            }
        }
    }
    @IBAction func moveToNext(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "CheckDataStoredInLocalDBController") as! CheckDataStoredInLocalDBController
        self.navigationController?.pushViewController(controller, animated: true)

    }
}
