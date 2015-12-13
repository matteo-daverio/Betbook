//
//  FakeModelBuilder.swift
//  Example-Swift
//
//  Created by Robert Nash on 22/09/2015.
//  Copyright © 2015 Robert Nash. All rights reserved.
//

import Foundation
import CollapsableTable

class CountryMenuSection: CollapsableTableViewSectionModelProtocol  {
    
    var title: String
    var isVisible: Bool
    var items: [AnyObject]
    
    init() {
        title = ""
        isVisible = false
        items = []
    }
}

class MenuModelBuilder {
	
	//Fixed number of option for CountryEuropeanCompetition
	private var listOfCountryOrEuropeanCompetition: [String] = []
	
	private var leagueForTheCountry = [String:[String]]()
	
	init(){
		addAvailableCountryOrEuropeanCompetition()
		addLeagueForCountry()
	}
    
	func buildMenu() -> [CollapsableTableViewSectionModelProtocol] {
        
        var collector = [CollapsableTableViewSectionModelProtocol]()
        
        for var i = 0; i < self.listOfCountryOrEuropeanCompetition.count ; i++ {
            
            let section = CountryMenuSection()
			
			section.title = self.listOfCountryOrEuropeanCompetition[i]
			if(i > 0){
				section.isVisible = false
			}else{
				section.isVisible = true
			}
			section.items = self.leagueForTheCountry[section.title]!
			
			
            collector.append(section)
        }
        
        return collector
    }
	
	//Initialize the array of Available Country Or European Competition
	private func addAvailableCountryOrEuropeanCompetition(){
		self.listOfCountryOrEuropeanCompetition.append("Italia")
		self.listOfCountryOrEuropeanCompetition.append("Inghilterra")
		self.listOfCountryOrEuropeanCompetition.append("Spagna")
		self.listOfCountryOrEuropeanCompetition.append("Francia")
		self.listOfCountryOrEuropeanCompetition.append("Germania")
		//	self.listOfCountryOrEuropeanCompetition.append("Champions Leaugue")
	}
	
	private func addLeagueForCountry(){
		self.leagueForTheCountry["Italia"] =
			["Serie A","Serie B","Coppa Italia","Super Coppa"
			//,"Lega Pro 1A","Lega Pro 1B"]
			]
		self.leagueForTheCountry["Inghilterra"] = ["Premier League","FA Cup","Capital One Cup","Cummunity Shield","League One","League Two"]
		self.leagueForTheCountry["Spagna"] = ["Liga","Super Coppa","Coppa del Re","Liga Segunda","Liga Segunda B","Liga Tercera"]
		self.leagueForTheCountry["Francia"] = ["Ligue 1","Ligue 2","Coupe de France","Coupe de la Ligue","Super Coppa","National","CFA"]
		self.leagueForTheCountry["Germania"] = ["Bundesliga","Bundesliga 2","Super Cup"]
		self.leagueForTheCountry["Champions League"] = []
	}
		
	
}