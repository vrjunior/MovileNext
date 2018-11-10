//
//  CourseTableViewController.swift
//  Next03
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import CoreData

class CourseTableViewController: UITableViewController {

    // MARK: - Properties
    var fetchedResultController: NSFetchedResultsController<Course>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCourses()
    }
    
    // MARK: - Methods
    private func loadCourses() {
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(keyPath: \Course.name, ascending: true)
        
        // its an array, you can pass more than one
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController?.delegate = self
        
        do {
            try fetchedResultController?.performFetch()
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.fetchedResultController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let course = fetchedResultController?.object(at: indexPath) else { return cell }
        
        cell.textLabel?.text = course.name
        
        return cell
    }
    
    @IBAction func addCourse(_ sender: Any) {
        
        let alert = UIAlertController(title: "Curso", message: nil, preferredStyle: .alert)
        let buttonAction = UIAlertAction(title: "Salvar", style: .default) { (_) in
            let courseName = alert.textFields?.first?.text
            
            let course = Course(context: self.context)
            course.name = courseName
            self.saveContext()
        }
        alert.addAction(buttonAction)

        alert.addTextField { (textField) in
            textField.placeholder = "Nome do curso"
        }
        
        self.present(alert, animated: true, completion: nil)
    }

}


// MARK: - NSFetchedResultsControllerDelegate
extension CourseTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        // you can switch and improve performance
        //        switch type {
        //        case .delete:
        //            break
        //        case .insert:
        //            break
        //        default:
        //            break
        //        }
        self.tableView.reloadData()
    }
}
