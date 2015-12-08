//
//  MatchListTableViewController.swift
//  CocoaPods
//
//  Created by Alessandro Cimbelli on 03/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class MatchListTableViewController: UITableViewController,SoccerInformationModelDelegate {

	//My model
	let soccerInformationModel = SingletonSoccerInformationModel().getInstance()
	
	var country: String?
	var league: String?
	
	var matches = [[Match]]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		soccerInformationModel.delegate = self
		soccerInformationModel.selectedCountryOrEuropeanCompetition(country!)
		soccerInformationModel.selectedLeague(league!)
		soccerInformationModel.getMatchList()
		
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - Table view delegat
	
	func setMatchList(matchList: [Match]?){
		
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if( matchList == nil ){
				print("Match non disponibili")
			}else{
				let organizedMatches = self.organizeForDate(matchList!)
				self.matches = organizedMatches
				self.tableView.reloadData()
			}
		}
		
	}
	
	private func organizeForDate(matchList: [Match]) -> [[Match]]{
		
		var organizedMatchList = [[Match]]()
		var differentDates = [String]()
		var i = 0
		for(; i < matchList.count; i++){
			if( !(differentDates.contains(matchList[i].date!) )){
				differentDates.append(matchList[i].date!)
			}
		}
		
		for(i = 0 ; i < differentDates.count; i++){
			var matchInTheSameDate = [Match]()
			for m in matchList{
				if(m.date! == differentDates[i]){
					matchInTheSameDate.append(m)
				}
			}
			organizedMatchList.append(matchInTheSameDate)
		}
		
		return organizedMatchList
	}
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matches[section].count
	}

	private struct StoryBoard {
		static let CellReuseIdentifier = "Match"
	}
	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier, forIndexPath: indexPath) as! MatchTableViewCell

        // Configure the cell...
		cell.match = matches[indexPath.section][indexPath.row]

        return cell
    }
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return matches.count
	}
	
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return (matches[section].first!.date)?.capitalizedString
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
