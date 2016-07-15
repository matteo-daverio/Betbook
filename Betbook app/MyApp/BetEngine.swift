//
//  BetEngine.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 18/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation

class BetEngine {
	
	func calculateOutput(importo: String, bonuS: String, giocate: [Bet]) -> BetEngineData{
		
		var quotaTotale = 1.00
		var bonus = Double(bonuS)!/100.0
		
		var valueUnderMinimumForBonus = false
		
		for q in giocate {
			quotaTotale = quotaTotale * Double(q.betValue!)!
			if(Double(q.betValue!)! < 1.30){
				valueUnderMinimumForBonus = true
			}
		}
		
		if(valueUnderMinimumForBonus){
			bonus = 0.00
		}
		
		var vincitaPotenziale = (Double(importo)! * quotaTotale)
		
		let addThanksToBonus = bonus * vincitaPotenziale
		
		vincitaPotenziale = vincitaPotenziale + addThanksToBonus
		
		return BetEngineData(quotaTotale: quotaTotale, vincitaPotenziale: vincitaPotenziale)
	}
}

struct BetEngineData {

	var quotaTotale: Double
	var vincitaPotenziale : Double

}
