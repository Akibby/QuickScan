//
//  CityTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the City List.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class CityTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // An array of strings that are the different cities.
    var cityTitles = ["Baton Rouge, La", "Carencro, La","Crowley, La","Denham Springs, La","Donaldsville, La","Dutchtown, La","Gamercy, La","Gonzales, La","Lafayette, La","Monroe, La","Napoleonville, La","New Orleans, La","New Roads, La","Praireville, La","West Monroe, La"]
    var city: String!
    
    // Loads the table.
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    // Defines the number of sections in the table.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Defines the number of rows in the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityTitles.count
    }

    // Function to build the cells.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "LocationTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = cityTitles[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation
    
    // Prepares data to be sent to a different page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        city = cityTitles[(selectedIndexPath?.row)!]
    }
}
