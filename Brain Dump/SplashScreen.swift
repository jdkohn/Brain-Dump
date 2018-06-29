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
    var categories = [NSDictionary]()
    var notes = [NSDictionary]()
    
    @IBAction func save(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHome", sender: nil)
    }
    
    @IBAction func skip(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHome", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        categories = cd.load(entityName: "Category")
        notes = cd.load(entityName: "Note")
    }
    

}
