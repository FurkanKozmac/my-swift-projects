//
//  ViewController.swift
//  SimpleNoteApplication
//
//  Created by Furkan Kozmaç on 11.02.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [String]()
    var idArray = [UUID]()
    var myID : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonOnClick))
        
        fetchData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name("dataEntered"), object: nil)
        
    }
    
    @objc func fetchData(){
        
         titleArray.removeAll(keepingCapacity: false)
         idArray.removeAll(keepingCapacity: false)
         
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let context = appDelegate.persistentContainer.viewContext
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
         fetchRequest.returnsObjectsAsFaults = false
         
         do{
             let getResult = try context.fetch(fetchRequest)
             
             if getResult.count > 0 {
                 
                 for result in getResult as! [NSManagedObject]{
                     if let title = result.value(forKey: "title") as? String {
                         titleArray.append(title)
                     }
                     
                     if let id = result.value(forKey: "id") as? UUID {
                         idArray.append(id)
                     }
                 }
                 tableView.reloadData()
             }
         }catch{
             print("Error")
         }
         
     }
    
    @objc func addButtonOnClick(){
        performSegue(withIdentifier: "toAddNotesVC", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myID = idArray[indexPath.row]
        performSegue(withIdentifier: "toNotesVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNotesVC" {
            let destinationVC = segue.destination as! NotesViewController
            destinationVC.choosenID = myID
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
            let uuidString = idArray[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == idArray[indexPath.row]{
                                context.delete(result)
                                titleArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                
                                self.tableView.reloadData()
                                
                                do{
                                    try context.save()
                                }catch{
                                  print("Error")
                                }
                                break
                            }
                        }
                        
                    }
                }
                
            }catch{
                print("Error")
            }
        }
    }

}

