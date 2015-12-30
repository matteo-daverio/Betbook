//
//  StatisticHttpRequest.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 29/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation
// Nella cartella del progetto digita: carthage update --platform iOS
import Kanna

protocol StatisticDelegate {

	func setRankingAndStatistic(ranking: RankingAndStatistic?)

}

class StatisticHttpRequest {
	
	//Property
	var delegate: StatisticDelegate?
	
	private var parserHtml = ParserHtml()
	
	private var dictionaryLeaguePath = [String:String]()
	
	
	init(){
		addTodictionaryLeaguePath()
	}
	
	func getRankingAndStatisticForLeague(league: String){
		
		let path = self.dictionaryLeaguePath[league]!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var rankingAndStatistic: RankingAndStatistic?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				rankingAndStatistic = self.parserHtml.getRankingAndStatisticFromHtml(doc)
			}
			
			if self.delegate != nil{
				
				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					self.delegate?.setRankingAndStatistic(rankingAndStatistic)
				})
			}
		}
		
		//serve per avviare il task
		task.resume()
		
	}
	
	private func addTodictionaryLeaguePath(){

		self.dictionaryLeaguePath["Serie A"] = "http://www.corrieredellosport.it/live/classifica-serie-a.html"
		self.dictionaryLeaguePath["Premier League"] = "http://www.corrieredellosport.it/live/classifica-PremierLeague.html"
		self.dictionaryLeaguePath["Liga"] = "http://www.corrieredellosport.it/live/classifica-LaLiga.html"
		self.dictionaryLeaguePath["Ligue 1"] = "http://www.corrieredellosport.it/live/classifica-Ligue1.html"
		self.dictionaryLeaguePath["Bundesliga"] = "http://www.corrieredellosport.it/live/classifica-Bundesliga.html"
	
	}
	
	
	
	
	
	
	
	
	
	
	
}


