//
//  RankingAndStatisticViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 29/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class RankingAndStatsticViewController: UIViewController, StatisticDelegate{
	
	let statisticHttpRequest = StatisticHttpRequest()
	
	
	
		override func viewDidLoad() {
			
			self.statisticHttpRequest.delegate = self
		
			self.statisticHttpRequest.getRankingAndStatisticForLeague("Serie A")
			self.statisticHttpRequest.getRankingAndStatisticForLeague("Liga")
			self.statisticHttpRequest.getRankingAndStatisticForLeague("Premier League")
			self.statisticHttpRequest.getRankingAndStatisticForLeague("Ligue 1")
			self.statisticHttpRequest.getRankingAndStatisticForLeague("Bundesliga")
		
		}
	
	
	
	
	
	
	
	
	
	
	
	
	func setRankingAndStatistic(ranking: RankingAndStatistic?) {
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(ranking != nil){
				for r in (ranking?.rankingList)! {
					print(r)
				}
				
				print(" ")
			}
		}
	}
	
}