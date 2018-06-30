//
//  SaveNoteViewController.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import UIKit

class SaveNoteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var text = ""
    var fromHome = false
    var categories: [Category] = []
    var notes: [Note] = []
    var cd = CoreDataManager()

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var existingCategory: UIPickerView!
    @IBOutlet weak var newCategoryField: UITextField!
    @IBAction func save(_ sender: Any) {
        var category = 0
        if(newCategoryField.text! != "") {
            if(categories.count == 0) {
                category = 0
            } else {
                category = Int(categories[categories.count - 1].id + 1)
            }
            let newCategory = ["name": newCategoryField.text!, "id": category] as NSDictionary
            cd.save(entityName: "Category", keys: newCategory)
            categories = cd.load(entityName: "Category") as! [Category]
        } else if(categories.count > 0) {
            category = Int(categories[existingCategory.selectedRow(inComponent: 0)].id)
        } else {
            return
        }
        let data = ["title": titleField.text!, "text": text, "category": category] as NSDictionary
        cd.save(entityName: "Note", keys: data)
        notes = cd.load(entityName: "Note") as! [Note]
        
        if(fromHome) {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        } else {
            performSegue(withIdentifier: "doneSaving", sender: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        performSegue(withIdentifier: "doneSaving", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = cd.load(entityName: "Category") as! [Category]
        notes = cd.load(entityName: "Note") as! [Note]
        existingCategory.delegate = self
        existingCategory.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "doneSaving") {
            let navC = segue.destination as! UINavigationController
            let controller = navC.childViewControllers[0] as! CategoryViewController
            controller.notes = notes
            controller.categories = categories
        }
    }
}
