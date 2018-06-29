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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = note.title!
        self.textView.text = note.text!
        self.textView.isEditable = false
    }
}
