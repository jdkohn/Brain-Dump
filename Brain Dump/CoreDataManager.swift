//
//  CoreDataManager.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class CoreDataManager {
    
    init() {
        print("Initialized CoreData Manager")
    }
    
    func save(entityName: String, keys: NSDictionary) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        for(key, value) in keys {
            newEntity.setValue(value, forKey: key as! String)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func load(entityName: String) -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            return result as! [NSManagedObject]
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "username") as! String)
//            }
        } catch {
            return [NSManagedObject]()
        }
    }
    
    func deleteRecords() -> Void {

    }
    
    func deleteCategory(id: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        
        let result = try? context.fetch(request)
        let resultData = result as! [Category]
        
        for object in resultData {
            if(object.id == id) {
                context.delete(object)
                break
            }
        }
        
        do {
            try context.save()
            print("saved!")
            deleteNotesForCategory(id: id, appDelegate: appDelegate, context: context)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func deleteNotesForCategory(id: Int, appDelegate: AppDelegate, context: NSManagedObjectContext) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let result = try? context.fetch(request)
        let resultData = result as! [Note]
        
        for object in resultData {
            if(object.category == id) {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func deleteNote(title: String, text: String, category: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let result = try? context.fetch(request)
        let resultData = result as! [Note]
        
        for object in resultData {
            if(Int(object.category) == category && object.title! == title && object.text! == text) {
                context.delete(object)
                break
            }
        }
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
}
