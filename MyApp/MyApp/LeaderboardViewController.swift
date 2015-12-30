//
//  LeaderboardViewController.swift
//  MyApp
//
//  Created by Matteo on 30/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit
import CollapsableTable

class LeaderboardViewController: CollapsableTableViewController, StatisticDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: UIViewController?
    let statisticHttpRequester = StatisticHttpRequest()
    
    var rankLabel: UILabel!
    var teamNameLabel: UILabel!
    var pointsLabel: UILabel!
    
    var teamImage: UIImageView!
    
    var history1: UIImageView!
    var history2: UIImageView!
    var history3: UIImageView!
    var history4: UIImageView!
    var history5: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false
        
        self.delegate?.reloadInputViews()
        
        self.tableView.registerNib(UINib(nibName: "OddsTableViewCell", bundle: nil), forCellReuseIdentifier: "OddCell")
        
        statisticHttpRequester.delegate = self
        
        statisticHttpRequester.getRankingAndStatisticForLeague("Serie A")
        
    }
    
    
    
    override func singleOpenSelectionOnly() -> Bool {
        return true
    }
    
    override func collapsableTableView() -> UITableView? {
        return tableView
    }
    
    
    // MARK: - StatisticDelegate 
    
    func setRankingAndStatistic(ranking: RankingAndStatistic?) {
        dispatch_async(dispatch_get_main_queue()){ () -> Void in
            if(ranking != nil){
                for r in (ranking?.rankingList)! {
                    print(r)
                }
                
                print(" ")
            }
            self.tableView.reloadData()
        }
    }
    
}



extension LeaderboardViewController{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! LeaderboardTableViewCell
        
        cell.backgroundView?.backgroundColor = UIColor.greenColor()
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LeaderboardCell")! as UITableViewCell
        
        
        
        return cell
    }
}

