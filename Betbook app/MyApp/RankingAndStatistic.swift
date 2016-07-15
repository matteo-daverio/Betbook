//
//  RankingAndStatistic.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 29/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation

class RankingAndStatistic {
	
	var rankingList = [RankingRow]()
	
}

class RankingRow : CustomStringConvertible {
	
	var pos: String = ""
	var team: String = ""
	var punti: String = ""
	var g: String = ""
	var v: String = ""
	var n: String = ""
	var p: String = ""
	var gf: String = ""
	var gs: String = ""
	var ultimeGiornate: [String] = []
	
	var description: String {
		
		var ug: String = ""
		
		for i in ultimeGiornate{
			ug.appendContentsOf(i + " ")
		}
		
		return pos + " " + team + " " + punti + " " + g + " " + v + " " + n + " " + p + " " + gf + " " + gs + " "+ug
		
	}
	
}