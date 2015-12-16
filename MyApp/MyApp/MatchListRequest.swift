//
//  MatchListRequest.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 08/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation
// Nella cartella del progetto digita: carthage update --platform iOS
import Kanna

protocol MatchListDelegate {
	//Gives back to the delegate the list of match scheduled
	func setMatchList(matchList: [Match]?)
}

class MatchListRequest {
	
	//Property
	var delegate: MatchListDelegate?
	
	private var parserHtml = ParserHtml()
	
	//Base path to achieve the http request
	private let basePath = "http://www.confrontaquote.it/calcio"
	
	//Helper string
	private let slash = "/"
	
	//Helper to get Strings of the model
	private let stringHelper = StringForTheWebHelper()
	
	
	//This function ask to the model to look for the odds available on the web according to the parameters setted before like country and league
	func getMatchList(uiCountryOrEuropeanCompetition: String, uiLeague: String ){
		
		let selectedCountryOrEuropeanCompetitionForTheWeb = stringHelper.selectedCountryOrEuropeanCompetition(uiCountryOrEuropeanCompetition)!
		
		let selectedLeagueForTheWeb = stringHelper.selectedLeague(uiLeague)!
		
		//At this point we should arleady have setted all the parameters to build the path, in the oppisite case we want to crash
		let path = basePath + slash + selectedCountryOrEuropeanCompetitionForTheWeb + slash + selectedLeagueForTheWeb
		
		//We create an url for the http request
		let url = NSURL(string: path)
		
		var matchList: [Match]?
		
		let session = NSURLSession.sharedSession()
		
		//Imposta il task
		//Le operazioni svolte dal task vanno su un altro thread!!! Quando faccio resume (lo avvio) e il task è eseguito a parte. Il task gira in maniera asincrona.
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				matchList = self.parserHtml.getMatchListFromHtml(doc,country: uiCountryOrEuropeanCompetition, league: uiLeague)
			}
			
			if self.delegate != nil{
				
				let list = matchList
				
				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					self.delegate?.setMatchList(list)
				})
			}
		}
		
		//serve per avviare il task
		task.resume()
	}
}