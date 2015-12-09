//
//  OddsModelBuilder.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 09/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation
import CollapsableTable

class OddsMenuSection: CollapsableTableViewSectionModelProtocol  {
	
	var title: String
	var isVisible: Bool
	var items: [String]
	
	init() {
		title = ""
		isVisible = false
		items = []
	}
}

class OddsModelBuilder {
	
	//Fixed kinds of odds
	private var listOfKindOfBet: [String] = []
	
	private var fieldsForTheKindOfBet = [String:[String]]()
	
	init(){
		addAvailableKindOfBet()
		addFieldForKindOfBet()
	}
	
	func buildMenu() -> [CollapsableTableViewSectionModelProtocol] {
		
		var collector = [CollapsableTableViewSectionModelProtocol]()
		
		let n = self.listOfKindOfBet.count
		
		for var i = 0; i < n ; i++ {
			
			let section = OddsMenuSection()
			
			section.title = self.listOfKindOfBet[i]
			if(i > 0){
				section.isVisible = false
			}else{
				section.isVisible = true
			}
				section.items = self.fieldsForTheKindOfBet[section.title]!
			
			
			collector.append(section)
		}
		
		return collector
	}
	
	//Initialize the array of Available kind of bet
	private func addAvailableKindOfBet(){
		self.listOfKindOfBet.append("Esito Finale")
		self.listOfKindOfBet.append("Primo Tempo")
		self.listOfKindOfBet.append("Doppia Chance")
		self.listOfKindOfBet.append("Under/Over 0.5")
		self.listOfKindOfBet.append("Under/Over 1.5")
		self.listOfKindOfBet.append("Under/Over 2.5")
		self.listOfKindOfBet.append("Under/Over 3.5")
		self.listOfKindOfBet.append("Under/Over 4.5")
//		self.listOfKindOfBet.append("Under/Over 5.5")
//		self.listOfKindOfBet.append("Under/Over 6.5")
//		self.listOfKindOfBet.append("Under/Over 7.5")
//		self.listOfKindOfBet.append("Under/Over 8.5")
//		self.listOfKindOfBet.append("Under/Over 9.5")
		self.listOfKindOfBet.append("Gol/No Gol")
		self.listOfKindOfBet.append("Primo Tempo Gol/No Gol")
		self.listOfKindOfBet.append("Secondo Tempo Gol/No Gol")
		self.listOfKindOfBet.append("Pari/Dispari")
	}
	
	private func addFieldForKindOfBet(){
		self.fieldsForTheKindOfBet["Esito Finale"] = ["1","X","2"]
		self.fieldsForTheKindOfBet["Primo Tempo"] = ["1","X","2"]
		self.fieldsForTheKindOfBet["Doppia Chance"] = ["1X","X2","12"]
		self.fieldsForTheKindOfBet["Under/Over 0.5"] = ["Over","Under"]
		self.fieldsForTheKindOfBet["Under/Over 1.5"] = ["Over","Under"]
		self.fieldsForTheKindOfBet["Under/Over 2.5"] = ["Over","Under"]
		self.fieldsForTheKindOfBet["Under/Over 3.5"] = ["Over","Under"]
		self.fieldsForTheKindOfBet["Under/Over 4.5"] = ["Over","Under"]
//		self.fieldsForTheKindOfBet["Under/Over 5.5"] = ["Over","Under"]
//		self.fieldsForTheKindOfBet["Under/Over 6.5"] = ["Over","Under"]
//		self.fieldsForTheKindOfBet["Under/Over 7.5"] = ["Over","Under"]
//		self.fieldsForTheKindOfBet["Under/Over 8.5"] = ["Over","Under"]
//		self.fieldsForTheKindOfBet["Under/Over 9.5"] = ["Over","Under"]
		self.fieldsForTheKindOfBet["Gol/No Gol"] = ["Gol","No Gol"]
		self.fieldsForTheKindOfBet["Primo Tempo Gol/No Gol"] = ["Gol","No Gol"]
		self.fieldsForTheKindOfBet["Secondo Tempo Gol/No Gol"] = ["Gol","No Gol"]
		self.fieldsForTheKindOfBet["Pari/Dispari"] = ["Pari","Dispari"]
		
	}
}
