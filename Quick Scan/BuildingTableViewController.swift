//
//  BuildingTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the Building List.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class BuildingTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // An array of  arrays of strings that are the different buildings grouped by location.
    var buildingTitles = [["FMOLHS","FML - 2051 Silverside - IS","FML - 7612 Picardy #G-F Legal","FML - FMOL Health System","FML - Info Svcs Perkins Rd","FML - Ollie Steele"],["Our Lady of the Lake","LAK - Our Lady of the Lake OLOL Main","LAK - 5120 Dijon Building - Bus Off.","LAK - 5128 Dijon - Acct.","LAK - 5311 Dijon - H/R","LAK - 5421 Didesse Suites A & B","LAK - 5745 Essen Crossing","LAK - Assumption Rural Health Clinic","LAK - Asumption Community Hospital","LAK - Baton Rouge Clinic","LAK - Bone & Joint Clinic","LAK - Goodwood","LAK - Imaging Center","LAK - MOB 1","LAK - MOB 2","LAK - MOB 3","LAK - Neighborhood Clinic Scotlandville","LAK - PCN 12 - Southeast Pediatrics","LAK - PCN 15 - Carl E. McLemore, Jr.","LAK - PCN 18 - Brian J. LeBlanc","LAK - PCN 2 - Family Practice Associates","LAK - PCN 24 - Paul B. Rachel","LAK - PCN 25 LPCP S. BR","LAK - PCN 28 - Senior Care","LAK - PCN 33 Pediatrics O'Neal","LAK - PCN 36 - Pediatrics Denham","LAK - PCN 39 - Dr. Carol Smothers","LAK - PCN 41","LAK - PCN 7 - Louis V. Montelaro","LAK - PCN 9 - Pediatric Medical Center","LAK - Plaza I","LAK - Silverside","LAK - St. Anthony","LAK - St. Claire","LAK - Storage Bldg Rm 133","LAK - Storage Bldg Rm 134","LAK - Storage Bldg Rm 135","LAK - Storage Bldg Rm 136","LAK - Tau Center","LAK - Villa St. Francis"],["College","COL - Admin Building - Perkins","COL - Health Career Institute","COL - Health Science & Health Science An","COL - Liberal Arts - Brittany","COL - Library - Didesse","COL - Nursing Building - Hennessy","COL - OLOL College of Nursing Main","COL - Science Building - Brittany","COL - Student Services - Brittany"]]
    
    
    var building: String!
    
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
        return buildingTitles.count
    }

    // Defines the number of rows in a section.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildingTitles[section].count - 1
    }

    // Function to build the cells.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        let bldg = shortenBuilding(buildingTitles[indexPath.section][indexPath.row + 1])
        cell.textLabel?.text = bldg
        return cell
    }
    
    // Creates the headers for the sections.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return buildingTitles[section][0]
    }
    
    // MARK: - Navigation
    
    // Prepares data to be sent to a different page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        building = buildingTitles[(selectedIndexPath?.section)!][(selectedIndexPath?.row)! + 1]
    }
    
    // MARK: - Actions
    
    // Shortens the text of the building
    func shortenBuilding(_ building: String) -> String{
        var bldg = building
        let range = bldg.startIndex..<bldg.characters.index(bldg.startIndex, offsetBy: 6)
        bldg.removeSubrange(range)
        
        return bldg
    }
}
