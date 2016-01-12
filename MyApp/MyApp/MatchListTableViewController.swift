//
//  MatchListTableViewController.swift
//  CocoaPods
//
//  Created by Alessandro Cimbelli on 03/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class MatchListTableViewController: UITableViewController,MatchListDelegate {

	let spinner = UIActivityIndicatorView(frame: CGRectMake(0,0,100,100))
	
	//My model
	let matchListModel = MatchListRequest()
	
	var country: String?
	var league: String?
	
	var matches = [[Match]]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//Importantissimo
		matchListModel.delegate = self
		
		self.title = league
		
		let bounds = UIScreen.mainScreen().bounds
		let widht = bounds.size.width
		let height = bounds.size.height
		
		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
		spinner.hidesWhenStopped = true
		spinner.transform = CGAffineTransformMakeScale(1.5, 1.5)
		let center = CGPoint(x: widht * 0.5, y: height * 0.2)
		
		
		
		spinner.center = CGPointMake(center.x, center.y)
		spinner.color = UIColor.blackColor()
		spinner.backgroundColor = UIColor.clearColor()
		self.view.addSubview(spinner)
		self.view.bringSubviewToFront(spinner)
		spinner.startAnimating()
		
		
		spinner.startAnimating()
		matchListModel.getMatchList(country!, uiLeague: league!)
		
		
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
				
				let title = "Match non disponibili"
				let message = "Non sono al momento previsti incontri per questa competizione"
				let okText = "Ok"
				
				let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
				
				let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
					self.spinner.stopAnimating()
					self.navigationController?.popViewControllerAnimated(true)
				})
				
				alert.addAction(okayButton)
				self.presentViewController(alert, animated: true, completion: nil)
				
			}else{
				let organizedMatches = self.organizeForDate(matchList!)
				self.matches = organizedMatches
				self.spinner.stopAnimating()
				self.tableView.reloadData()
			}
		}
		
	}
	
	private func helperMatchDate(match: Match) -> String{
		
		let date = match.date
		
		var arrayWordsInDate = date?.componentsSeparatedByString(" ")
		
		let day = arrayWordsInDate![1]
		var mese = ""
		let year = arrayWordsInDate![3]
		let hour = match.hour!
		
		
		switch((arrayWordsInDate![2]).capitalizedString){
		case "Gennaio":
			mese = "1"
		case "Febbraio":
			mese = "2"
		case "Marzo":
			mese = "3"
		case "Aprile":
			mese = "4"
		case "Maggio":
			mese = "5"
		case "Giugno":
			mese = "6"
		case "Luglio":
			mese = "7"
		case "Agosto":
			mese = "8"
		case "Settembre":
			mese = "9"
		case "Ottobre":
			mese = "10"
		case "Novembre":
			mese = "11"
		case "Dicembre":
			mese = "12"
		default:
			break
		}
		
		return day + "-" + mese + "-" + year + " " + hour
		
	}
	
	private func organizeForDate(var matchList: [Match]) -> [[Match]]{
		
		var organizedMatchList = [[Match]]()
		
		var differentDates = [String]()
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = "dd-MM-yyyy HH:mm"
		formatter.timeZone = NSTimeZone(abbreviation: "GTM")
		
		let currentDate = NSDate().dateByAddingTimeInterval(3600)

		var i = 0
	
		for(; i < matchList.count; i++){
			let mDate = formatter.dateFromString(helperMatchDate(matchList[i]))?.dateByAddingTimeInterval(3600)
			
			if(mDate?.compare(currentDate) == NSComparisonResult.OrderedAscending){
				matchList.removeAtIndex(i)
				i--
			}
		}
		
		for(i = 0; i < matchList.count; i++){
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
	
	override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		
		view.tintColor = UIColor(red: 20.0/255.0, green: 29.0/255.0, blue: 74.0/255.0, alpha: 1.0)
		
		let headerView = view as! UITableViewHeaderFooterView
		headerView.textLabel?.textColor = UIColor.whiteColor()

	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "showMatchOddsViewMVC"){
			
			let upcoming: MatchOddsViewController = segue.destinationViewController as! MatchOddsViewController
			
			let indexPath = self.tableView.indexPathForSelectedRow!
			
			let helper = StringForTheWebHelper()
			
			upcoming.selectedCountryOrEuropeanCompetition = helper.dictionaryOfCountryOrEuropeanCompetition[self.country!]
			upcoming.selectedLeague = helper.dictionaryOfLeagues[self.league!]
			let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! MatchTableViewCell
			upcoming.homeTeam = cell.homeTeamName.text!
			upcoming.awayTeam = cell.awayTeamName.text!
			cell.match!.country = self.country!
			cell.match!.league = self.league!
			upcoming.match = cell.match!
			
		}
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
