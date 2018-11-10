//
//  StudentsTableViewController.swift
//  Next03
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import CoreData

class StudentsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var fetchedResultController: NSFetchedResultsController<Student>?

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStudent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let studentsViewController = segue.destination as? StudentViewController {
            guard let cell = sender as? UITableViewCell else { return }
            guard let indexPath = self.tableView.indexPath(for: cell) else { return }
            studentsViewController.student = fetchedResultController?.object(at: indexPath)
        }
    }
    
    
    // MARK: - Methods
    private func loadStudent() {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(keyPath: \Student.name, ascending: true)
        let sortDescritorDate = NSSortDescriptor(key: #keyPath(Student.birthday), ascending: true)
        
        let filter = "brito"
        let predicate = NSPredicate(format: "name contains [cd] %@", filter)
        fetchRequest.predicate = predicate
        
        // its an array, you can pass more than one
        fetchRequest.sortDescriptors = [sortDescriptor, sortDescritorDate]
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
        return fetchedResultController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let student = fetchedResultController?.object(at: indexPath) else { return cell }
        
        cell.textLabel?.text = student.name
        cell.detailTextLabel?.text = "\(student.age) anos"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let student = self.fetchedResultController?.object(at: indexPath) else { return }
            context.delete(student)
            
            self.saveContext()
        }
    }
    
}


// MARK: - NSFetchedResultsControllerDelegate
extension StudentsTableViewController: NSFetchedResultsControllerDelegate {
    
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
