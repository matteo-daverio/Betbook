//
//  SoccerInformationServer.swift
//  CocoaPods
//
//  Created by Alessandro Cimbelli on 03/11/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation
import Kanna



protocol SoccerInformationModelDelegate {
	//Gives back to the delegate the list of match scheduled
	func setMatchList(matchList: [Match]?)
}


//Singleton
class SoccerInformationModel {
	
	//Property
	var delegate: SoccerInformationModelDelegate?
	
	private var parserHtml = ParserHtml()
	
	//Indicates a country or an european competition
	private var selectedCountryOrEuropeanCompetition: String?
	
	//Indicates the specific championship of the coutry
	private var selectedLeague: String?
	
	//Base path to achieve the http request
	private let basePath = "http://www.confrontaquote.it/calcio"
	
	//Helper string
	private let slash = "/"
	
	//Helper to get Strings of the model
	private let stringHelper = StringForTheWebHelper()
	
	
	//Methods
	
	//This function ask to the model to look for the odds available on the web according to the parameters setted before like country and league
	func getMatchList(){
		
		//At this point we should arleady have setted all the parameters to build the path, in the oppisite case we want to crash
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague!
		
		//We create an url for the http request
		let url = NSURL(string: path)
		
		var matchList: [Match]?
		
		let session = NSURLSession.sharedSession()
		
		//Imposta il task
		//Le operazioni svolte dal task vanno su un altro thread!!! Quando faccio resume (lo avvio) e il task è eseguito a parte. Il task gira in maniera asincrona.
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				matchList = self.parserHtml.getMatchListFromHtml(doc, country: self.selectedCountryOrEuropeanCompetition!, league: self.selectedLeague!)
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
	
	
	func getOddsRisultatoFinaleForMatch(homeTeam: String, awayTeam: String){
		
		let kindOfBet = stringHelper.getKindOfBet("Esito Finale")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getRisultatoFinaleFromHtml(doc)
			}
			
//			if self.delegate != nil{
//				
//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
//					self.delegate?.setMatchList(list)
//				})
//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsRisultatoFinalePrimoTempoForMatch(homeTeam: String, awayTeam: String){
	
		let kindOfBet = stringHelper.getKindOfBet("Primo Tempo")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getRisultatoFinaleFromHtml(doc)
			}
			
			//			if self.delegate != nil{
			//
			//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
			//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
			//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
			//					self.delegate?.setMatchList(list)
			//				})
			//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsDoppiaChanceForMatch(homeTeam: String, awayTeam: String){
		
		let kindOfBet = stringHelper.getKindOfBet("Doppia Chance")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getDoppiaChanceFromHtml(doc)
			}
			
			//			if self.delegate != nil{
			//
			//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
			//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
			//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
			//					self.delegate?.setMatchList(list)
			//				})
			//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	
	func getOddsUnderOverForMatch(homeTeam: String, awayTeam: String){
		
		let kindOfBet = stringHelper.getKindOfBet("Under/Over")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getUnderOverFromHtml(doc)
			}
			
			//			if self.delegate != nil{
			//
			//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
			//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
			//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
			//					self.delegate?.setMatchList(list)
			//				})
			//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsGolNoGolForMatch(homeTeam: String, awayTeam: String){
		
		let kindOfBet = stringHelper.getKindOfBet("Gol/No Gol")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getGolNoGolFromHtml(doc)
			}
			
			//			if self.delegate != nil{
			//
			//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
			//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
			//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
			//					self.delegate?.setMatchList(list)
			//				})
			//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsGolNoGolPrimoTempoForMatch(homeTeam: String, awayTeam: String){
		
		let kindOfBet = stringHelper.getKindOfBet("Primo Tempo Gol/No Gol")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getGolNoGolFromHtml(doc)
			}
			
			//			if self.delegate != nil{
			//
			//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
			//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
			//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
			//					self.delegate?.setMatchList(list)
			//				})
			//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsGolNoGolSecondoTempoForMatch(homeTeam: String, awayTeam: String){
		
		let kindOfBet = stringHelper.getKindOfBet("Secondo Tempo Gol/No Gol")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getGolNoGolFromHtml(doc)
			}
			
			//			if self.delegate != nil{
			//
			//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
			//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
			//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
			//					self.delegate?.setMatchList(list)
			//				})
			//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsPariDispariForMatch(homeTeam: String, awayTeam: String){
		
		let kindOfBet = stringHelper.getKindOfBet("Pari/Dispari")
		let match = homeTeam.lowercaseString + "-" + awayTeam.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		print(path)
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				self.parserHtml.getPariDispariFromHtml(doc)
			}
			
			//			if self.delegate != nil{
			//
			//				//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
			//				//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
			//				dispatch_async(dispatch_get_main_queue(), { () -> Void in
			//					self.delegate?.setMatchList(list)
			//				})
			//			}
		}
		
		//serve per avviare il task
		task.resume()
	}
}