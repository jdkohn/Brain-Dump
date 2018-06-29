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
    
    var text: String!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        self.textView.text = text
        self.textView.isEditable = false
    }
}
