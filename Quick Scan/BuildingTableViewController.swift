//
//  BuildingTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class BuildingTableViewController: UITableViewController {
    
    var buildingTitles = [["FMOLHS","FML - 2051 Silverside - IS","FML - 7612 Picardy #G-F Legal","FML - FMOL Health System","FML - Info Svcs Perkins Rd","FML - Ollie Steele"],["Our Lady of the Lake","LAK - 5120 Dijon Building - Bus Off.","LAK - 5128 Dijon - Acct.","LAK - 5311 Dijon - H/R","LAK - 5421 Didesse Suites A & B","LAK - 5745 Essen Crossing","LAK - Assumption Rural Health Clinic","LAK - Asumption Community Hospital","LAK - Baton Rouge Clinic","LAK - Bone & Joint Clinic","LAK - Goodwood","LAK - Imaging Center","Lak - MOB 1","LAK - MOB 2","LAK - MOB 3","LAK - Neighborhood Clinic Scotlandville","LAK - Our Lady of the Lake OLOL Main","LAK - PCN 12 - Southeast Pediatrics","LAK - PCN 15 - Carl E. McLemore, Jr.","LAK - PCN 18 - Brian J. LeBlanc","Lak - PCN 2 - Family Practice Associates","LAK - PCN 24 - Paul B. Rachel","LAK - PCN 25 LPCP S. BR","LAK - PCN 28 - Senior Care","LAK - PCN 33 Pediatrics O'Neal","LAK - PCN 36 - Pediatrics Denham","LAK - PCN 39 - Dr. Carol Smothers","LAK - PCN 41","LAK - PCN 7 - Louis V. Montelaro","LAK - PCN 9 - Pediatric Medical Center","LAK - Plaza I","LAK - Silverside","LAK - St. Anthony","LAK - St. Claire","LAK - Storage Bldg Rm 133","LAK - Storage Bldg Rm 134","LAK - Storage Bldg Rm 135","LAK - Storage Bldg Rm 136","LAK - Tau Center","LAK - Villa St. Francis"],["College","COL - Admin Building - Perkins","COL - Health Career Institute","COL - Health Science & Health Science An","COL - Liberal Arts - Brittany","COL - Library - Didesse","COL - Nursing Building - Hennessy","COL - OLOL College of Nursing Main","COL - Science Building - Brittany","COL - Student Services - Brittany"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return buildingTitles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return buildingTitles[section].count - 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = buildingTitles[indexPath.section][indexPath.row + 1]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return buildingTitles[section][0]
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
