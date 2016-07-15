//
//  RankingAndStatisticViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 29/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class RankingAndStatsticViewController: UITableViewController, StatisticDelegate{
	
	let spinner = UIActivityIndicatorView(frame: CGRectMake(0,0,100,100))
	
	let statisticHttpRequest = StatisticHttpRequest()
	
	var league: String?
	
	var ranking: RankingAndStatistic?{
		didSet{
			self.tableView.reloadData()
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
		
		self.statisticHttpRequest.delegate = self
		
		self.tableView.registerNib(UINib(nibName: "RankingAndStatsticCellTableViewCell", bundle: nil), forCellReuseIdentifier: "RankingAndStatsticCellTableViewCell")
		
		self.statisticHttpRequest.getRankingAndStatisticForLeague(league!)
		
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
		
//		self.statisticHttpRequest.getRankingAndStatisticForLeague("Liga")
//		self.statisticHttpRequest.getRankingAndStatisticForLeague("Premier League")
//		self.statisticHttpRequest.getRankingAndStatisticForLeague("Ligue 1")
//		self.statisticHttpRequest.getRankingAndStatisticForLeague("Bundesliga")
		
	}
	
	func setRankingAndStatistic(ranking: RankingAndStatistic?) {
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(ranking != nil){
				for r in (ranking?.rankingList)! {
					print(r)
				}
			
				print(" ")
				self.ranking = ranking
				
				self.spinner.stopAnimating()
			}
		}
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
			return 80.0
	}
		
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.0
	}
		
		
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
			
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(ranking == nil){
			return 0
		}else{
			return (ranking?.rankingList.count)!
		}
	}
		
	override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
//		let cell = tableView.cellForRowAtIndexPath(indexPath) as! RankingAndStatsticCellTableViewCell
//			
//		cell.backgroundView?.backgroundColor = UIColor.greenColor()
//			
	}
		
	override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
	}
		
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
			let cell = tableView.dequeueReusableCellWithIdentifier("RankingAndStatsticCellTableViewCell", forIndexPath: indexPath) as! RankingAndStatsticCellTableViewCell
		
			cell.positionLabel.text = ranking?.rankingList[indexPath.row].pos
			cell.teamNameLabel.text = ranking?.rankingList[indexPath.row].team
			cell.pointLabel.text = ranking?.rankingList[indexPath.row].punti
		
			var imageName = (ranking?.rankingList[indexPath.row].team)!.stringByReplacingOccurrencesOfString("ö", withString: "o")
		
			imageName = imageName.stringByReplacingOccurrencesOfString("á", withString: "a")
		
		
		
			cell.teamImageView.image = UIImage(named: imageName.lowercaseString)
		
		for(var i = 0; i < ranking?.rankingList[indexPath.row].ultimeGiornate.count ; i++){
			let esito = ranking?.rankingList[indexPath.row].ultimeGiornate[i]
			
			switch(i + 1){
			case 1:
				cell.history1ImageView.image = UIImage(named: esito!)
			case 2:
				cell.history2ImageView.image = UIImage(named: esito!)
			case 3:
				cell.history3ImageView.image = UIImage(named: esito!)
			case 4:
				cell.history4ImageView.image = UIImage(named: esito!)
			case 5:
				cell.history5ImageView.image = UIImage(named: esito!)
			default:
				break
			
			}
		}
			return cell
	}
}