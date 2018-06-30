//
//  AddNoteViewController.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var editor: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editor.becomeFirstResponder()
        
        var saveButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.save))
        self.navigationItem.setRightBarButton(saveButton, animated: false)
    }
    
    @objc func save() {
        performSegue(withIdentifier: "saveFromNew", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "saveFromNew") {
            let controller = segue.destination as! SaveNoteViewController
            controller.text = editor.text
            controller.fromHome = true
        }
    }
}
