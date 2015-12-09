//
//  OddsViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 09/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit
import CollapsableTable

class OddsViewController: CollapsableTableViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	let menu = OddsModelBuilder().buildMenu()
	
	override func model() -> [CollapsableTableViewSectionModelProtocol]? {
		return menu
	}
	
	override func sectionHeaderNibName() -> String? {
		return "OddsMenuSectionHeaderView"
	}
	
	override func singleOpenSelectionOnly() -> Bool {
		return true
	}
	
	override func collapsableTableView() -> UITableView? {
		return tableView
	}
	
//	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//		self.performSegueWithIdentifier("showMatchListViewMVC", sender: self)
//	}
	
//	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		if(segue.identifier == "showMatchListViewMVC"){
//			
//			let upcoming: MatchListTableViewController = segue.destinationViewController as! MatchListTableViewController
//			
//			let indxPath = self.tableView.indexPathForSelectedRow!
//			let countyString = self.menu[indxPath.section].title
//			let leagueString = self.menu[indxPath.section].items[indxPath.row]
//			
//			upcoming.country = countyString
//			upcoming.league = leagueString
//		}
//	}
}

extension OddsViewController {
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 44.0
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44.0
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCellWithIdentifier("OddCell")! as UITableViewCell
//		
//		let bet = menu[indexPath.section].items[indexPath.row]
//		
//		cell.textLabel?.text = bet
//		
//		return cell
		
		return tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
	}
}