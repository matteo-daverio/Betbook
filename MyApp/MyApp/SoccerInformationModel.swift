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
	private let basePath = "https://www.confrontaquote.it/calcio"
	
	//Helper string
	private let slash = "/"
	
	//Fixed number of option for CountryEuropeanCompetition
	private var listOfCountryOrEuropeanCompetition: [String] = []
	
	//Fixed number of option for the league
	private var listOfLeague: [String] = []
	
	//Fixed kinds of odds
	private var listOfKindOfBet: [String] = []
	
	//Fixed name of brands
	private var listOfBrands: [String] = []
	
	//Dictionary that associate the normal string of a coutry to the string for thr web url
	private var dictionaryOfCountryOrEuropeanCompetition = [String:String]()
	
	//Dictionary that associate the normal string of a league to the string for thr web url
	private var dictionaryOfLeagues = [String:String]()
	
	//Dictionary that associate the kind of bet for the web query
	private var dictionaryOfKindOfBet = [String:String]()
	
	
	
	
	//Methods
	
	//This function set the scope of the country or of the european competition of this model
	func selectedCountryOrEuropeanCompetition(league: String){
		self.selectedCountryOrEuropeanCompetition = selectedCountryOrEuropeanCompetitionToselectedCountryOrEuropeanCompetitionForWebRequest(league)
	}
	
	//This function set the scope of the specific championship for this model
	func selectedLeague(league: String){
		self.selectedLeague = leagueToleagueForWebRequest(league)
	}
	
	//This function prepare the country/european competition name to be insert in the http request
	private func selectedCountryOrEuropeanCompetitionToselectedCountryOrEuropeanCompetitionForWebRequest(country: String) -> String{
		//In case of nil we want to crash
		return dictionaryOfCountryOrEuropeanCompetition[country]!
	}
	
	
	//This function prepare the league name to be insert in the http request
	private func leagueToleagueForWebRequest(league: String) -> String{
		//In case of nil we want to crash
		return dictionaryOfLeagues[league]!
	}
	
	
	//Returns the list of CountryOrEuropeanCompetition
	func getListOfCountryOrEuropeanCompetition() -> [String]{
		return self.listOfCountryOrEuropeanCompetition
	}
	
	//Returns the list of available championships	
	func getListOfLeague() -> [String]{
		return self.listOfLeague
	}
	
	
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
				matchList = self.parserHtml.getMatchListFromHtml(doc)
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
		
		let kindOfBet = dictionaryOfKindOfBet["Esito Finale"]
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
	
		let kindOfBet = dictionaryOfKindOfBet["Primo Tempo"]
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
		
		let kindOfBet = dictionaryOfKindOfBet["Doppia Chance"]
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
		
		let kindOfBet = dictionaryOfKindOfBet["Under/Over"]
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
		
		let kindOfBet = dictionaryOfKindOfBet["Gol/No Gol"]
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
		
		let kindOfBet = dictionaryOfKindOfBet["Primo Tempo Gol/No Gol"]
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
		
		let kindOfBet = dictionaryOfKindOfBet["Secondo Tempo Gol/No Gol"]
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
		
		let kindOfBet = dictionaryOfKindOfBet["Pari/Dispari"]
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//Methods for the initialization of the model
	
	init(){
		addAvailableCountryOrEuropeanCompetition()
		addAvailableLeague()
		addAvailableKindOfBet()
		addAvailableBrands()
		addToDictionaryOfCountryOrEuropeanCompetitionDictionary()
		addToDictionaryOfLeagues()
		addToDictionaryOfKindOfBet()
		
	}
	
	//Initialize the array of Available kind of bet
	private func addAvailableKindOfBet(){
		self.listOfKindOfBet.append("Esito Finale")
		self.listOfKindOfBet.append("Primo Tempo")
		self.listOfKindOfBet.append("Doppia Chance")
		self.listOfKindOfBet.append("Under/Over")
		self.listOfKindOfBet.append("Gol/No Gol")
		self.listOfKindOfBet.append("Primo Tempo Gol/No Gol")
		self.listOfKindOfBet.append("Secondo Tempo Gol/No Gol")
		self.listOfKindOfBet.append("Pari/Dispari")
	}
	
	//Initialize the array of Available kind of Brands
	private func addAvailableBrands(){
		self.listOfBrands.append("BetClick.it")
		self.listOfBrands.append("Bwin")
		self.listOfBrands.append("William Hill")
		self.listOfBrands.append("GazzaBet")
		self.listOfBrands.append("Unibet")
		self.listOfBrands.append("NetBet")
		self.listOfBrands.append("PaddyPower")
		self.listOfBrands.append("BetFlag")
		self.listOfBrands.append("Sport Yes")
		self.listOfBrands.append("Eurobet")
		self.listOfBrands.append("Betfair")
		self.listOfBrands.append("Lottomatica")
		self.listOfBrands.append("Totosi")
	}
	
	
	
	
	//Initialize the array of Available Country Or European Competition
	private func addAvailableCountryOrEuropeanCompetition(){
		self.listOfCountryOrEuropeanCompetition.append("Italia")
		self.listOfCountryOrEuropeanCompetition.append("Inghilterra")
		self.listOfCountryOrEuropeanCompetition.append("Spagna")
		self.listOfCountryOrEuropeanCompetition.append("Francia")
		self.listOfCountryOrEuropeanCompetition.append("Germania")
		self.listOfCountryOrEuropeanCompetition.append("Champions Leaugue")
	}
	
	
	
	//Initialize the array of Available Leagues
	private func addAvailableLeague() {
		
		//Italian championships
		self.listOfLeague.append("Serie A")
		self.listOfLeague.append("Serie B")
		self.listOfLeague.append("Coppa Italia")
		self.listOfLeague.append("Super Coppa")
		self.listOfLeague.append("Lega Pro 1A")
		self.listOfLeague.append("Lega Pro 1B")
		
		//English championships
		self.listOfLeague.append("Premier League")
		self.listOfLeague.append("FA Cup")
		self.listOfLeague.append("Capital One Cup")
		self.listOfLeague.append("Cummunity Shield")
		self.listOfLeague.append("League One")
		self.listOfLeague.append("League Two")
		
		//Spanish championships
		self.listOfLeague.append("Liga")
		self.listOfLeague.append("Super Coppa")
		self.listOfLeague.append("Coppa del Re")
		self.listOfLeague.append("Liga Segunda")
		self.listOfLeague.append("Liga Segunda B")
		self.listOfLeague.append("Liga Tercera")
		
		//French championships
		self.listOfLeague.append("Ligue 1")
		self.listOfLeague.append("Ligue 2")
		self.listOfLeague.append("Coupe de France")
		self.listOfLeague.append("Coupe de la Ligue")
		self.listOfLeague.append("Super Coppa")
		self.listOfLeague.append("National")
		self.listOfLeague.append("CFA")
		
		//German championships
		self.listOfLeague.append("Bundesliga")
		self.listOfLeague.append("Bundesliga 2")
		self.listOfLeague.append("Super Cup")
		
	}
	
	
	
	//Initialize all the common string to the web one for country and e.c.
	private func addToDictionaryOfCountryOrEuropeanCompetitionDictionary(){
		self.dictionaryOfCountryOrEuropeanCompetition["Italia"] = "italia"
		self.dictionaryOfCountryOrEuropeanCompetition["Inghilterra"] = "inghilterra"
		self.dictionaryOfCountryOrEuropeanCompetition["Spagna"] = "spagna"
		self.dictionaryOfCountryOrEuropeanCompetition["Francia"] = "francia"
		self.dictionaryOfCountryOrEuropeanCompetition["Germania"] = "germania"
		self.dictionaryOfCountryOrEuropeanCompetition["Champions Leaugue"] = "champions-league"
	}
	
	
	
	
	//Initialize all the common string to the web one for leagues
	
	private func addToDictionaryOfLeagues(){
		//Italian
		self.dictionaryOfLeagues["Serie A"] = "serie-a"
		self.dictionaryOfLeagues["Serie B"] = "serie-b"
		self.dictionaryOfLeagues["Coppa Italia"] = "coppa-italia"
		self.dictionaryOfLeagues["Super Coppa"] = "super-coppa"
		self.dictionaryOfLeagues["Lega Pro 1A"] = "lega-pro-1a"
		self.dictionaryOfLeagues["Lega Pro 1B"] = "lega-pro-1b"
		
		//English
		self.dictionaryOfLeagues["Premier League"] = "premier-league"
		self.dictionaryOfLeagues["FA Cup"] = "fa-cup"
		self.dictionaryOfLeagues["Capital One Cup"] = "capital-one-cup"
		self.dictionaryOfLeagues["Cummunity Shield"] = "community-shield"
		self.dictionaryOfLeagues["League One"] = "league-one"
		self.dictionaryOfLeagues["League Two"] = "league-two"
		
		//Spanish
		self.dictionaryOfLeagues["Liga"] = "liga"
		self.dictionaryOfLeagues["Super Coppa"] = "super-coppa"
		self.dictionaryOfLeagues["Coppa del Re"] = "coppa-del-re"
		self.dictionaryOfLeagues["Liga Segunda"] = "liga-segunda"
		self.dictionaryOfLeagues["Liga Segunda B"] = "liga-segunda-b"
		self.dictionaryOfLeagues["Liga Tercera"] = "liga-tercera"
		
		//French
		self.dictionaryOfLeagues["Ligue 1"] = "ligue-1"
		self.dictionaryOfLeagues["Ligue 2"] = "ligue-2"
		self.dictionaryOfLeagues["Coupe de France"] = "coupe-de-france"
		self.dictionaryOfLeagues["Coupe de la Ligue"] = "coupe-de-la-ligue"
		self.dictionaryOfLeagues["Super Coppa"] = "super-coppa"
		self.dictionaryOfLeagues["National"] = "national"
		self.dictionaryOfLeagues["CFA"] = "cfa"
		
		
		//German
		self.dictionaryOfLeagues["Bundesliga"] = "bundesliga"
		self.dictionaryOfLeagues["Bundesliga 2"] = "bundesliga-2"
		self.dictionaryOfLeagues["Super Cup"] = "super-cup"
	}
	
	
	//Initialize all the common string to the web one for the kinds of bet
	private func addToDictionaryOfKindOfBet(){
		self.dictionaryOfKindOfBet["Esito Finale"] = "esito-finale"
		self.dictionaryOfKindOfBet["Primo Tempo"] = "primo-tempo"
		self.dictionaryOfKindOfBet["Doppia Chance"] = "doppia-chance"
		self.dictionaryOfKindOfBet["Under/Over"] = "totale-gol-under-over"
		self.dictionaryOfKindOfBet["Gol/No Gol"] = "entrambe-le-squadre-a-segno"
		self.dictionaryOfKindOfBet["Primo Tempo Gol/No Gol"] = "entrambe-le-squadre-a-segno-primo-tempo"
		self.dictionaryOfKindOfBet["Secondo Tempo Gol/No Gol"] = "entrambe-le-squadre-a-segno-secondo-tempo"
		self.dictionaryOfKindOfBet["Pari/Dispari"] = "gol-totali-pari-dispari"

	}
}