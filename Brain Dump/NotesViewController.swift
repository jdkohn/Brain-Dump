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
    @IBOutlet weak var newButton: UIBarButtonItem!
    
    var notes = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as UITableViewCell
        cell.detailTextLabel!.text = (notes[indexPath.row].value(forKey: "title") as! String)
        return cell
    }
    
}
