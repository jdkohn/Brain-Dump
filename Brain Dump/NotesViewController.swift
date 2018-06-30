//
//  NotesViewController.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import UIKit

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    let cd = CoreDataManager()
    
    var notes: [Note] = []
    var displayNotes: [Note] = []
    var categories: [Category] = []
    var categoryName: String!
    var categoryNum: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNew))
        self.navigationItem.setRightBarButton(addButton, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categories = cd.load(entityName: "Category") as! [Category]
        notes = cd.load(entityName: "Note") as! [Note]
        
        populateDisplayNotes()
        
        table.dataSource = self
        table.delegate = self
        table.reloadData()
    }
    
    func populateDisplayNotes() {
        displayNotes = []
        for note in notes {
            if(note.category == categoryNum) {
                displayNotes.append(note)
            }
        }
    }
    
    @objc func addNew() {
        print("!")
        self.performSegue(withIdentifier: "addFromNotes", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewNoteDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as UITableViewCell
        cell.textLabel!.text = displayNotes[indexPath.row].title!
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let note = displayNotes[indexPath.row]
            cd.deleteNote(title: note.title!, text: note.text!, category: Int(note.category))
            notes = cd.load(entityName: "Note") as! [Note]
            populateDisplayNotes()
            self.table.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewNoteDetail") {
            let controller = segue.destination as! NoteDetailViewController
            controller.note = displayNotes[sender as! Int]
        }
    }
}
