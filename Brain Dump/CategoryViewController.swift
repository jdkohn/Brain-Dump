//
//  CategoryViewController.swift
//  Brain Dump
//
//  Created by Jacob Kohn on 6/29/18.
//  Copyright © 2018 Jacob Kohn. All rights reserved.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var newButton: UIBarButtonItem!
    
    var categories = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as UITableViewCell
        cell.detailTextLabel!.text = (categories[indexPath.row].value(forKey: "name") as! String)
        return cell
    }
}
