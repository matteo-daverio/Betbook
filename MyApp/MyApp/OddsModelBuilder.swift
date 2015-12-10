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
	var items: [AnyObject]
	
	init() {
		title = ""
		isVisible = false
		items = []
	}
}

class Item {
	var name: String?
	var val: String?
	
	init(name: String, val: String){
		self.name = name
		self.val = val
	}
}

class OddsModelBuilder {
	
	//Fixed kinds of odds
	private var listOfKindOfBet: [String] = []
	
	private var fieldsForTheKindOfBet = [String:[Item]]()
	
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
				section.items = (self.fieldsForTheKindOfBet[section.title]!)
			
			
			collector.append(section)
		}
		
		return collector
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
	
	private func addFieldForKindOfBet(){
		self.fieldsForTheKindOfBet["Esito Finale"] = [Item(name: "1",val: ""),Item(name: "X",val: ""),Item(name: "2",val: "")]
		self.fieldsForTheKindOfBet["Primo Tempo"] =  [Item(name: "1",val: ""),Item(name: "X",val: ""),Item(name: "2",val: "")]
		self.fieldsForTheKindOfBet["Doppia Chance"] = [Item(name: "1X",val: ""),Item(name: "X2",val: ""),Item(name: "12",val: "")]
		self.fieldsForTheKindOfBet["Under/Over"] =
			[Item(name: "Over 0.5", val: ""),Item(name: "Under 0.5",val: ""),
				Item(name: "Over 1.5", val: ""),Item(name: "Under 1.5",val: ""),
				Item(name: "Over 2.5", val: ""),Item(name: "Under 2.5",val: ""),
				Item(name: "Over 3.5", val: ""),Item(name: "Under 3.5",val: ""),
				Item(name: "Over 4.5", val: ""),Item(name: "Under 4.5",val: ""),
//				Item(name: "Over 5.5", val: ""),Item(name: "Under 5.5",val: ""),
//				Item(name: "Over 6.5", val: ""),Item(name: "Under 6.5",val: ""),
//				Item(name: "Over 8.5", val: ""),Item(name: "Under 7.5",val: ""),
//				Item(name: "Over 9.5", val: ""),Item(name: "Under 9.5",val: ""),
		]
		self.fieldsForTheKindOfBet["Gol/No Gol"] =
			[Item(name: "Gol", val: ""),Item(name: "No Gol", val: "")]
		
		self.fieldsForTheKindOfBet["Primo Tempo Gol/No Gol"] =
			[Item(name: "Gol", val: ""),Item(name: "No Gol", val: "")]
		
		self.fieldsForTheKindOfBet["Secondo Tempo Gol/No Gol"] =
			[Item(name: "Gol", val: ""),Item(name: "No Gol", val: "")]
		
		self.fieldsForTheKindOfBet["Pari/Dispari"] = [Item(name: "Pari", val: ""),Item(name: "Dispari", val: "")]
		
		
		
		
	}
	
	func getNumberOfBrand() -> Int{
		return listOfKindOfBet.count
	}
}
