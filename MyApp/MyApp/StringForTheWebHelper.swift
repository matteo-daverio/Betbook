//
//  StringForTheWebHelper.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 08/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation

class StringForTheWebHelper {
	
	//Fixed number of option for CountryEuropeanCompetition
	private var listOfCountryOrEuropeanCompetition: [String] = []
	
	//Fixed number of option for the league
	private var listOfLeague: [String] = []
	
	//Fixed kinds of odds
	private var listOfKindOfBet: [String] = []
	
	//Fixed name of brands
	private var listOfBrands: [String] = []
	
	//Dictionary that associate the normal string of a coutry to the string for thr web url
	var dictionaryOfCountryOrEuropeanCompetition = [String:String]()
	
	//Dictionary that associate the normal string of a league to the string for thr web url
	var dictionaryOfLeagues = [String:String]()
	
	//Dictionary that associate the kind of bet for the web query
	
	private var dictionaryOfKindOfBet = [String:String]()
	
	
	//Methods
	
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
	
	func getKindOfBet(bet: String) -> String?{
		return dictionaryOfKindOfBet[bet]
	}
	
	//This function set the scope of the country or of the european competition of this model
	func selectedCountryOrEuropeanCompetition(league: String) -> String?{
		return selectedCountryOrEuropeanCompetitionToselectedCountryOrEuropeanCompetitionForWebRequest(league)
	}
	
	//This function set the scope of the specific championship for this model
	func selectedLeague(league: String) -> String?{
		return leagueToleagueForWebRequest(league)
	}
	
	//This function prepare the country/european competition name to be insert in the http request
	private func selectedCountryOrEuropeanCompetitionToselectedCountryOrEuropeanCompetitionForWebRequest(country: String) -> String{
		//In case of nil we want to crash
		return dictionaryOfCountryOrEuropeanCompetition[country]!
	}
	
	
	//This function prepare the league name to be insert in the http request
	private func leagueToleagueForWebRequest(league: String) -> String?{
		//In case of nil we want to crash
		return dictionaryOfLeagues[league]
	}
	
	
	
	
	//MARK: Model String DB
	
	
	
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
		self.listOfBrands.append("Iziplay")
		self.listOfBrands.append("Unibet")
		self.listOfBrands.append("NetBet")
		self.listOfBrands.append("Bet-At-Home")
		self.listOfBrands.append("PaddyPower")
		self.listOfBrands.append("Sisal")
		self.listOfBrands.append("BetFlag")
		self.listOfBrands.append("Sport Yes")
		self.listOfBrands.append("Eurobet")
		self.listOfBrands.append("Betfair")
		self.listOfBrands.append("Lottomatica")
		self.listOfBrands.append("Totosi")
	}
	
	func giveIndexOfTheBrand(brand: String) -> Int{
		return self.listOfBrands.indexOf(brand)!
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
//		self.listOfLeague.append("Super Coppa")
//		self.listOfLeague.append("Lega Pro 1A")
//		self.listOfLeague.append("Lega Pro 1B")
		
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
		self.dictionaryOfKindOfBet["Primo Tempo Gol/No Gol"] = "entrambe-le-squadre-a-segno-1-tempo"
		self.dictionaryOfKindOfBet["Secondo Tempo Gol/No Gol"] = "entrambe-le-squadre-a-segno-2-tempo"
		self.dictionaryOfKindOfBet["Pari/Dispari"] = "gol-totali-pari-dispari"
		
	}
	
}