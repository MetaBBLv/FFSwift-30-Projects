//
//  ViewController.swift
//  FFHitList
//
//  Created by zhou on 2019/7/27.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var people: [NSManagedObject] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationTitle()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        self.fetchCoreData(managedContext)
        
        
        
        
    }
    
    func setupNavigationTitle() {
        title = "The List"
    }


    func fetchCoreData(_ managedContext: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results =
            try managedContext.fetch(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let person = people[indexPath.row]
        cell.textLabel!.text = person.value(forKey: "name") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // remove the deleted item form the model
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.delete(people[indexPath.row] as NSManagedObject)
            do {
                try managedContext.save()
                people.remove(at: indexPath.row)
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            // remove the delete item from the 'UITTableView'
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
        }
    }
    
    //IBActions
    @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveName(textField!.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction) -> Void in
        })
        
        alert.addTextField { (textField: UITextField) -> Void in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK : - CoreData func
    func saveName(_ name: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedCOntext = appDelegate.managedObjectContext

        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedCOntext)
        let person = NSManagedObject(entity: entity!, insertInto: managedCOntext)
        person.setValue(name, forKey: "name")
        do {
            try managedCOntext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}

