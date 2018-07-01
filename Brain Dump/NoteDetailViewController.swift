//
//  NoteDetailViewController.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var note: Note!
    var editButton: UIBarButtonItem!
    var saveButton: UIBarButtonItem!
    let cd = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = note.title!
        self.textView.text = note.text!
        self.textView.isEditable = false
        
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.edit))
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        self.navigationItem.setRightBarButton(editButton, animated: false)
    }
    
    @objc func edit() {
        self.textView.isEditable = true
        self.textView.becomeFirstResponder()
        self.navigationItem.setRightBarButton(saveButton, animated: false)
    }
    
    @objc func save() {
        self.textView.isEditable = false
        cd.updateNote(title: note.title!, oldText: note.text!, category: Int(note.category), newText: self.textView.text)
        self.navigationItem.setRightBarButton(editButton, animated: false)
    }
    
    
}
