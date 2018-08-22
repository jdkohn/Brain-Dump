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
    @IBOutlet weak var toggle: UISegmentedControl!
    
    @IBAction func toggleDidChange(_ sender: Any) {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    let cd = CoreDataManager()
    let blue = UIColor(red: 0.30196 , green: 0.713725, blue: 0.97647, alpha: 1.0)
    var notes: [Note] = []
    var displayNotes: [Note] = []
    var completedNotes: [Note] = []
    var categories: [Category] = []
    var categoryName: String!
    var categoryNum: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNew))
        self.navigationItem.setRightBarButton(addButton, animated: false)
        self.toggle.tintColor = blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categories = cd.load(entityName: "Category") as! [Category]
        notes = cd.load(entityName: "Note") as! [Note]
        
        populateDisplayNotes()
        toggle.selectedSegmentIndex = 0
        table.dataSource = self
        table.delegate = self
        table.reloadData()
    }
    
    func populateDisplayNotes() {
        displayNotes = []
        completedNotes = []
        for note in notes {
            if(note.category == categoryNum) {
                if(note.done) {
                    completedNotes.append(note)
                } else {
                    displayNotes.append(note)
                }
            }
        }
    }
    
    @objc func addNew() {
        self.performSegue(withIdentifier: "addFromNotes", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(toggle.selectedSegmentIndex == 0) {
            return displayNotes.count
        }
        return completedNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableCell
        if(toggle.selectedSegmentIndex == 0) {
            cell.nameLabel.text = displayNotes[indexPath.row].title!
            cell.button.setImage(#imageLiteral(resourceName: "unchecked.png"), for: .normal)
            cell.button.setImage(#imageLiteral(resourceName: "checked.png"), for: .selected)
        } else {
            cell.nameLabel.text = completedNotes[indexPath.row].title!
            cell.button.setImage(#imageLiteral(resourceName: "checked.png"), for: .normal)
            cell.button.setImage(#imageLiteral(resourceName: "unchecked.png"), for: .selected)
        }
        
        cell.button.addTarget(self, action: #selector(updateDoneFor(sender:)), for: .touchUpInside)
        cell.button.tag = indexPath.row
        return cell
    }
    
    @objc func updateDoneFor(sender: UIButton) {
        var note = Note()
        var done = false
        if(toggle.selectedSegmentIndex == 0) {
            note = displayNotes[sender.tag]
            done = true
        } else {
            note = completedNotes[sender.tag]
        }
        self.cd.toggleComplete(title: note.title!, text: note.text!, category: Int(note.category), done: done)
        self.populateDisplayNotes()
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            var note = Note()
            if(toggle.selectedSegmentIndex == 0) {
                note = displayNotes[indexPath.row]
            } else {
                note = completedNotes[indexPath.row]
            }
            
            cd.deleteNote(title: note.title!, text: note.text!, category: Int(note.category))
            notes = cd.load(entityName: "Note") as! [Note]
            populateDisplayNotes()
            self.table.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewNoteDetail") {
            let controller = segue.destination as! NoteDetailViewController
            let index = self.table.indexPath(for: sender as! UITableViewCell)
            if(toggle.selectedSegmentIndex == 0) {
                controller.note = displayNotes[index!.row]
            } else {
                controller.note = completedNotes[index!.row]
            }
        }
    }
}

class NoteTableCell: UITableViewCell {
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var button: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
