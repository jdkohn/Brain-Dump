//
//  CategoryViewController.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var categories: [Category] = []
    var notes: [Note] = []
    let cd = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNew))
        self.navigationItem.setRightBarButton(addButton, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categories = cd.load(entityName: "Category") as! [Category]
        notes = cd.load(entityName: "Note") as! [Note]
        
        table.delegate = self
        table.dataSource = self
        table.reloadData()
    }
    
    @objc func addNew() {
        self.performSegue(withIdentifier: "addFromCategories", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewCategoryNotes", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as UITableViewCell
        cell.textLabel!.text =  categories[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewCategoryNotes") {
            let controller = segue.destination as! NotesViewController
            let rowNum = sender as! Int
            controller.categoryNum = rowNum
            controller.categoryName = categories[rowNum].name
        }
    }
}
