//
//  ViewController.swift
//  OfflineStorageWithCoreData
//
//  Created by RaviKrishna on 10/07/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableViewObj: UITableView!
    var tasks: [Tasks] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        self.fetchStatements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchStatements()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func fetchStatements() {
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        do{
            tasks = try context.fetch(fetchRequest)
            self.tableViewObj.reloadData()
        }
        catch {
            print("Failed to fetch tasks: \(error)")
        }
    }
    
    func deleteTask(_ task: Tasks) {
        context.delete(task)
        
        do {
            try context.save()
            fetchStatements()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewObj.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as UITableViewCell
        cell.textLabel?.text = tasks[indexPath.row].title
//        cell.detailTextLabel?.text = tasks[indexPath.row].subTitle
        cell.detailTextLabel?.text = "Hello"

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            deleteTask(task)
        }
    }
}
