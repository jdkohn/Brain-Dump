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
    
    func load(entityName: String) -> [NSDictionary] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            return result as! [NSDictionary]
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "username") as! String)
//            }
        } catch {
            return [["Fail": "Oops"]]
        }
    }
}
