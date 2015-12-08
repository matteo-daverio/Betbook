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
	
	var homeTeam: String?
	var awayTeam: String?
	var date: String?
	var hour: String?
	var risultatoFinaleOdds: RisultatoFinale?
	var risultatoFinalePrimoTempoOdds: RisultatoFinale?
	var underOver: UnderOver?
	var golNoGol: GolNoGol?
	var golNoGolPrimoTempo: GolNoGol?
	var golNoGolSecondoTempo: GolNoGol?
	var pariDispari: PariDispari?
	
	var description: String {
		return date! + " " + hour! + " " + homeTeam! + " " + awayTeam!
	}
	
	//Methods

	init(homeTeam: String, awayTeam: String, date: String, hour: String){
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

	
}

class DoppiaChance {
	
	// 1x
	var unoX = [Odd]()
	// x2
	var xDue = [Odd]()
	// 12
	var unoDue = [Odd]()
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
	
	var over5_5 = [Odd]()
	var under5_5 = [Odd]()
	
	var over6_5 = [Odd]()
	var under6_5 = [Odd]()
	
	var over7_5 = [Odd]()
	var under7_5 = [Odd]()
	
	var over8_5 = [Odd]()
	var under8_5 = [Odd]()
	
	var over9_5 = [Odd]()
	var under9_5 = [Odd]()
}

class GolNoGol {
	
	var gol = [Odd]()
	var noGol = [Odd]()
}

class PariDispari {
	
	var pari = [Odd]()
	var dispari = [Odd]()
}

class Odd : CustomStringConvertible{
	var brand: String?
	var value: String?
	var best: Bool = false
	
	var description: String {
		return brand! + " " + value! + " " + "\(best)"
	}
}