//
//  ViewController.swift
//  Example-Swift
//
//  Created by Robert Nash on 22/09/2015.
//  Copyright © 2015 Robert Nash. All rights reserved.
//

//Accordion Menu

import UIKit
import CollapsableTable

class MenuViewController: CollapsableTableViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let menu = MenuModelBuilder().buildMenu()
    
    override func model() -> [CollapsableTableViewSectionModelProtocol]? {
        return menu
    }

    override func sectionHeaderNibName() -> String? {
        return "MenuSectionHeaderView"
    }
    
    override func singleOpenSelectionOnly() -> Bool {
        return true
    }
    
    override func collapsableTableView() -> UITableView? {
        return tableView
    }
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		 self.performSegueWithIdentifier("showMatchListViewMVC", sender: self)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "showMatchListViewMVC"){
			
			let upcoming: MatchListTableViewController = segue.destinationViewController as! MatchListTableViewController
			
			let indxPath = self.tableView.indexPathForSelectedRow!
			let countyString = self.menu[indxPath.section].title
			let leagueString = self.menu[indxPath.section].items[indxPath.row]
			
			upcoming.country = countyString
			upcoming.league = leagueString as? String
		}
	}
}

extension MenuViewController {
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 44.0
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44.0
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
		
		let league = menu[indexPath.section].items[indexPath.row]
		
		cell.textLabel?.text = league as? String
		cell.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 0.85)
		
		return cell
	}
}
