//
//  Match.swift
//  CocoaPods
//
//  Created by Alessandro Cimbelli on 03/11/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation

class Match: CustomStringConvertible {
	
	//Properties
	
	var country: String?
	var league: String?
	var homeTeam: String?
	var awayTeam: String?
	var date: String?
	var hour: String?
	var risultatoFinaleOdds: RisultatoFinale?
	var risultatoFinalePrimoTempoOdds: RisultatoFinale?
	var doppiaChance: DoppiaChance?
	var underOver: UnderOver?
	var golNoGol: GolNoGol?
	var golNoGolPrimoTempo: GolNoGol?
	var golNoGolSecondoTempo: GolNoGol?
	var pariDispari: PariDispari?
	
	var description: String {
		return date! + " " + hour! + " " + homeTeam! + " " + awayTeam!
	}
	
	//Methods

	init(homeTeam: String, awayTeam: String, date: String, hour: String, country: String, league: String){
		self.homeTeam = homeTeam
		self.awayTeam = awayTeam
		self.date = date
		self.hour = hour
	}
}

class RisultatoFinale {
	
	var home = [Odd]()
	var  tie = [Odd]()
	var away = [Odd]()

	func flatArrayGivenTheBrandIndex(bIndex: Int)->[String]{
		return [home[bIndex].value,tie[bIndex].value,away[bIndex].value]
	}
}

class DoppiaChance {
	
	// 1x
	var unoX = [Odd]()
	// x2
	var xDue = [Odd]()
	// 12
	var unoDue = [Odd]()
	
	func flatArrayGivenTheBrandIndex(bIndex: Int)->[String]{
		return [unoX[bIndex].value,xDue[bIndex].value,unoDue[bIndex].value]
	}
}

class UnderOver {
	
	var over0_5 = [Odd]()
	var under0_5 = [Odd]()
	
	var over1_5 = [Odd]()
	var under1_5 = [Odd]()
	
	var over2_5 = [Odd]()
	var under2_5 = [Odd]()
	
	var over3_5 = [Odd]()
	var under3_5 = [Odd]()
	
	var over4_5 = [Odd]()
	var under4_5 = [Odd]()
	
//	var over5_5 = [Odd]()
//	var under5_5 = [Odd]()
//	
//	var over6_5 = [Odd]()
//	var under6_5 = [Odd]()
//	
//	var over7_5 = [Odd]()
//	var under7_5 = [Odd]()
//	
//	var over8_5 = [Odd]()
//	var under8_5 = [Odd]()
//	
//	var over9_5 = [Odd]()
//	var under9_5 = [Odd]()
	
	func flatArrayGivenTheBrandIndex(bIndex: Int)->[String]{
			return
				[over0_5[bIndex].value, under0_5[bIndex].value,
					over1_5[bIndex].value, under1_5[bIndex].value,
					over2_5[bIndex].value, under2_5[bIndex].value,
					over2_5[bIndex].value, under2_5[bIndex].value,
					over3_5[bIndex].value, under3_5[bIndex].value,
					over4_5[bIndex].value, under4_5[bIndex].value]
//					over5_5[bIndex].value, under5_5[bIndex].value,
//					over6_5[bIndex].value, under6_5[bIndex].value,
//					over7_5[bIndex].value, under7_5[bIndex].value,
//					over8_5[bIndex].value, under8_5[bIndex].value,
//					over9_5[bIndex].value, under9_5[bIndex].value]
	}
}

class GolNoGol {
	
	var gol = [Odd]()
	var noGol = [Odd]()
	
	func flatArrayGivenTheBrandIndex(bIndex: Int)->[String]{
		return [gol[bIndex].value,noGol[bIndex].value]
	}
}

class PariDispari {
	
	var pari = [Odd]()
	var dispari = [Odd]()
	
	func flatArrayGivenTheBrandIndex(bIndex: Int)->[String]{
		return [pari[bIndex].value, dispari[bIndex].value]
	}
}

class Odd : CustomStringConvertible{
	var brand: String = ""
	var value: String = "1.00"
	var best: Bool = false
	
	var description: String {
		return brand + " " + value + " " + "\(best)"
	}
}