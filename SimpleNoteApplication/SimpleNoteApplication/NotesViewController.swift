//
//  NotesViewController.swift
//  SimpleNoteApplication
//
//  Created by Furkan Kozmaç on 11.02.2023.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    
    var choosenID : UUID?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let uuidString = choosenID?.uuidString {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
            fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                
                let results = try context.fetch(fetchRequest)
                
                    for result in results as! [NSManagedObject] {
                        
                        if let title = result.value(forKey: "title") as? String {
                            titleLabel.text = title
                        }
                        
                        if let notes = result.value(forKey: "note") as? String {
                            noteLabel.text = notes
                        }
                        
                        if let image = result.value(forKey: "image") as? Data {
                            imageView.image = UIImage(data: image)
                        }
                        
                    }
                
            }catch{
                print("Error")
            }
            
        }
    }
    



}
