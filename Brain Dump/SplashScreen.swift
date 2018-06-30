//
//  SplashScreen.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import UIKit

class SplashScreen: UIViewController {
    
    @IBOutlet weak var textEditor: UITextView!
    let cd = CoreDataManager()
    var categories = [Category]()
    var notes = [Note]()
    
    @IBAction func save(_ sender: Any) {
        self.performSegue(withIdentifier: "saveFromSplash", sender: nil)
    }
    
    @IBAction func skip(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHome", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textEditor.becomeFirstResponder()
    }
    
    func loadData() {
        categories = cd.load(entityName: "Category") as! [Category]
        notes = cd.load(entityName: "Note") as! [Note]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "saveFromSplash") {
            let controller = segue.destination as! SaveNoteViewController
            controller.fromHome = false
            controller.text = textEditor.text
        }
    }
}
