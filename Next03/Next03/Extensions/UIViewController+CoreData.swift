//
//  UIViewController+CoreData.swift
//  Next03
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var context: NSManagedObjectContext {
        return self.appDelegate.persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
