//
//  ParserHtml.swift
//  CocoaPods
//
//  Created by Alessandro Cimbelli on 12/11/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation
import Kanna
import WebKit

class ParserHtml {
	
	//Property
	//Fixed name of brands
	private var listOfBrands: [String] = []
	private var dictionaryTeam = [String: NameTeamWebSite]()
	private var tr_class = "diff-row eventTableRow bc"
	private var prova = "TableRow bc"
	//Nella doppia chance ad esempio indica che non ci sono quote per il brand
	private var np_o = "np o"
	private var bc_co_o = "bc bs o"
	private var bc_co_o_b = "bc bs o b"
	
	
	init(){
		addAvailableBrands()
		addAllTeamsExceptions()
	}
	
	func getIndexOfBrand(brand: String) -> Int {
		var i = 0
		for(; i < listOfBrands.count; i++){
			if(brand == listOfBrands[i]){
				return i
			}
		}
		return 0
	}
	
	//Helper function that tells us if the row analized is good or not
	private func tr_class(input: String?) ->Bool {
		if(input == nil){
			return false
		}
		
		if(input == tr_class){
			return true
		}else{
			let arrayOfWords = input!.componentsSeparatedByString(" ")
			for w in arrayOfWords {
				switch(w){
					case "eventTableRow":
						return true
					case "diff-row":
						return true
				default:
						break
				}
			}
		}
		return false
	}
	
	//Helper function that help us tu dedect if the odd considere is the best or is empty or is a normal one
	private func switchHelper(specifica: String, value: String) -> Int{
		if(value == "0"){
			return 3
		}
		
		let arrayOfElementSpecifica = specifica.componentsSeparatedByString(" ")
		if(arrayOfElementSpecifica.last! == "b"){
			return 2
		}
		
		return 1
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
		self.listOfBrands.append("Sisal Matchpoint")
		self.listOfBrands.append("BetFlag")
		self.listOfBrands.append("Sport Yes")
		self.listOfBrands.append("Eurobet")
		self.listOfBrands.append("Betfair")
		self.listOfBrands.append("Lottomatica")
		self.listOfBrands.append("Totosi")
	}
	
	
	//Methods
	
	
	
	//This function takes out the list of events from an html page and gives back an array of matches (if available)
	func getMatchListFromHtml(doc: HTMLDocument, country: String, league: String)->[Match]?{
		
		let arrayBody = doc.css("tbody")
		let bodyTable = arrayBody.first
		
		if(bodyTable == nil){
			return nil
		}
		
		var currentDate: String?
		var currentHour: String?
		var countEvent = 0
		var currentHomeTeam: String?
		var currentAwayTeam: String?
		
		var arrayMatch:[Match]?
		
		// Search for nodes by CSS
		
		//Ciclo per le date
		for tr in bodyTable!.css("tr, class") {
			
			if(tr["class"] == "minitable-row"){
				return nil
			}
			
			if(tr["class"] == "date first"){
				currentDate = tr.text!
			}else{
				
				countEvent = 0
				
				if(tr["data-market-id"] != ""){
					
					for td in tr.css("td, class, data-participant-id"){
						
						if(td["class"] == "time"){
							currentHour = td.text!
							continue
						}
						
						if(td["data-participant-id"] != ""){
							
							
							for span in td.css("span, class"){
								
								if(span["class"] == "fixtures-bet-name"){
									if(countEvent == 0){
										currentHomeTeam = span.text!
									}
									
									if(countEvent == 2){
										currentAwayTeam = span.text!
									}
									
									countEvent++
								}
							}
						}
					}
				}

				
				
				let match = Match(homeTeam: currentHomeTeam!, awayTeam: currentAwayTeam!, date: currentDate!, hour: currentHour!, country: country, league: league)
				
				if(arrayMatch == nil){
					arrayMatch = [Match]()
				}
				arrayMatch!.append(match)
			}
		}
		return arrayMatch
	}
	
	
	
	//This function takes out the list of odds from an html page and gives back an array of RisultatoFinale (if available)
	func getRisultatoFinaleFromHtml(doc: HTMLDocument)->RisultatoFinale?{
		
		let arrayBody = doc.css("tbody")
		let nameTeamWeb = doc.css("table").first
		let tie = "Pareggio"
		let bodyTable = arrayBody.first
		if(bodyTable == nil){
			return nil
		}
		
		let arrayNames = nameTeamWeb!["data-sname"]?.componentsSeparatedByString(" v ")
		
		if(arrayNames == nil){
			return nil
		}
		
		let homeTeam = arrayNames![0]
		let awayTeam = arrayNames![1]
		
		
		let risultatoFinale = RisultatoFinale()
		var countOdd = 0
		for tr in bodyTable!.css("tr, class, data-bname") {
			
			if(!(tr_class(tr["class"]!))){
				continue
			}
			
			let check = tr["data-bname"]!
			
			let result = getFinalResultCase(homeTeam, away: awayTeam, check: check)
			//Inizializzo il counter per i brand
			countOdd = 0;
			
			for td in tr.css("td, class, data-odig"){
				
				let odd = Odd()
				let a = td["class"]
				let b = td["data-odig"]
				if(a == nil || nameTeamWeb == nil || b == nil){
					continue
				}
				
				//Where to go
				let w = switchHelper(a!, value: b!)
				
				switch(w){
					
				case 1:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
					
				case 2:
					odd.best = true
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
				case 3:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
				default: continue
				}
				switch(result!){
				case 0:
					risultatoFinale.home.append(odd)
					
				case 1:
					risultatoFinale.tie.append(odd)
		
				case 2:
					risultatoFinale.away.append(odd)
					
				default: break
				}
				//Fine singolo ciclo per coppia quota brand
				countOdd++
			}
			//Fine controllo tutte quote per un evento
		}
		
//		print(homeTeam)
//		print(risultatoFinale.home)
//		print(tie)
//		print(risultatoFinale.tie)
//		print(awayTeam)
//		print(risultatoFinale.away)
		
		return risultatoFinale
	}
	
	
	func getRisultatoFinalePrimoTempoFromHtml(doc: HTMLDocument)->RisultatoFinale?{
		 print("Risultato finale primo tempo")
		 return self.getRisultatoFinaleFromHtml(doc)
	}
	
	
	
	func getDoppiaChanceFromHtml(doc: HTMLDocument)->DoppiaChance?{
		let arrayBody = doc.css("tbody")
		let nameTeamWeb = doc.css("table").first
		let bodyTable = arrayBody.first
		if(bodyTable == nil || nameTeamWeb == nil){
			return nil
		}
		//TODO attenzione alle squadre tipo ac milan
		let arrayNames = nameTeamWeb!["data-sname"]?.componentsSeparatedByString(" v ")
		
		if(arrayNames == nil){
			return nil
		}
		
		let homeT = arrayNames![0]
		let awayT = arrayNames![1]
		
		let doppiaChance = DoppiaChance()
		
		var countOdd = 0
		for tr in bodyTable!.css("tr, class, data-bname") {
			
			if(!(tr_class(tr["class"]!))){
				continue
			}
			
			let homeTieAwayArray = tr["data-bname"]!.componentsSeparatedByString("-")
			
			let left = homeTieAwayArray[0]
			let right = homeTieAwayArray[1]
		
			let result = doubleChanceCase(homeT,awayT: awayT,left: left,right: right)
			
			
			//Inizializzo il counter per i brand
			countOdd = 0;
			
			for td in tr.css("td, class, data-odig"){
				
				let odd = Odd()
				let a = td["class"]
				let b = td["data-odig"]
				if(a == nil || nameTeamWeb == nil || b == nil){
					continue
				}
				
				//Where to go
				let w = switchHelper(a!, value: b!)
				
				switch(w){
					
				case 1:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
					
				case 2:
					odd.best = true
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
				case 3:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
				default: continue
				}
				
				switch(result!){
				case 0:
					doppiaChance.unoX.append(odd)
					
				case 1:
					doppiaChance.xDue.append(odd)
					
				case 2:
					doppiaChance.unoDue.append(odd)
					
				default: break
				}
				//Fine singolo ciclo per coppia quota brand
				countOdd++
			}
			//Fine controllo tutte quote per un evento
		}

//		print(" ")
//		print("Doppia Chance")
//		print(doppiaChance.unoX)
//		print(doppiaChance.xDue)
//		print(doppiaChance.unoDue)
		
		return doppiaChance
	}
	
	func getUnderOverFromHtml(doc: HTMLDocument)->UnderOver?{
	
		let arrayBody = doc.css("tbody")
		let nameTeamWeb = doc.css("table").first
		let bodyTable = arrayBody.first
		//For this specific odd nameTeamWeb is not needed
		if(bodyTable == nil || nameTeamWeb == nil){
			return nil
		}
		
		let underOver = UnderOver()
		
		var countOdd = 0
		for tr in bodyTable!.css("tr, class, data-bname") {
		
			if(!(tr_class(tr["class"]))){
				continue
			}
			
			//Inizializzo il counter per i brand
			countOdd = 0;
			
			for td in tr.css("td, class, data-odig"){
				
				let odd = Odd()
				let a = td["class"]
				let b = td["data-odig"]
				if(a == nil || nameTeamWeb == nil || b == nil){
					continue
				}
				
				//Where to go
				let w = switchHelper(a!, value: b!)
				
				switch(w){
					
				case 1:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
					
				case 2:
					odd.best = true
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
				case 3:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
				default: continue
				
				}
				
				switch(tr["data-bname"]!){
				case "Over 0.5":
					underOver.over0_5.append(odd)
				case "Under 0.5":
					underOver.under0_5.append(odd)
				case "Over 1.5":
					underOver.over1_5.append(odd)
				case "Under 1.5":
					underOver.under1_5.append(odd)
				case "Over 2.5":
					underOver.over2_5.append(odd)
				case "Under 2.5":
					underOver.under2_5.append(odd)
				case "Over 3.5":
					underOver.over3_5.append(odd)
				case "Under 3.5":
					underOver.under3_5.append(odd)
				case "Over 4.5":
					underOver.over4_5.append(odd)
				case "Under 4.5":
					underOver.under4_5.append(odd)
//				case "Over 5.5":
//					underOver.over5_5.append(odd)
//				case "Under 5.5":
//					underOver.under5_5.append(odd)
//				case "Over 6.5":
//					underOver.over6_5.append(odd)
//				case "Under 6.5":
//					underOver.under6_5.append(odd)
//				case "Over 7.5":
//					underOver.over7_5.append(odd)
//				case "Under 7.5":
//					underOver.under7_5.append(odd)
//				case "Over 8.5":
//					underOver.over8_5.append(odd)
//				case "Under 8.5":
//					underOver.under8_5.append(odd)
//				case "Over 9.5":
//					underOver.over9_5.append(odd)
//				case "Under 9.5":
//					underOver.under9_5.append(odd)
//					
				default: break
				}
				//Fine singolo ciclo per coppia quota brand
				countOdd++
			}
		}
		return underOver
	}
	
	func getGolNoGolFromHtml(doc: HTMLDocument)->GolNoGol?{
	
		let arrayBody = doc.css("tbody")
		let nameTeamWeb = doc.css("table").first
		let bodyTable = arrayBody.first
		if(bodyTable == nil || nameTeamWeb == nil){
			return nil
		}
		
		//TODO attenzione alle squadre tipo ac milan
		let arrayNames = nameTeamWeb!["data-sname"]?.componentsSeparatedByString(" v ")
		
		if(arrayNames == nil){
			return nil
		}
		
		let golNoGol = GolNoGol()
		
		var countOdd = 0
		
		for tr in bodyTable!.css("tr, class, data-bname") {
			
			if(!(tr_class(tr["class"]))){
				continue
			}
			
			//Inizializzo il counter per i brand
			countOdd = 0;
			
			for td in tr.css("td, class, data-odig"){
				
				let odd = Odd()
				let a = td["class"]
				let b = td["data-odig"]
				if(a == nil || nameTeamWeb == nil || b == nil){
					continue
				}
			
				//Where to go
				let w = switchHelper(a!, value: b!)
				
				switch(w){
					
				case 1:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
					
				case 2:
					odd.best = true
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
				case 3:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
				default: continue
					
				}
				
				switch(tr["data-bname"]!){
					case "No":
						golNoGol.noGol.append(odd)
					case "Yes":
						golNoGol.gol.append(odd)
					default: break
				}
				
				//Fine singolo ciclo per coppia quota brand
				countOdd++
				
			}
		}
		
//		print(" ")
//		print("Gol noGol")
//		print(golNoGol.gol)
//		print(golNoGol.noGol)
		
		return golNoGol
	}
	
	func getPariDispariFromHtml(doc: HTMLDocument)->PariDispari?{
		
		let arrayBody = doc.css("tbody")
		let nameTeamWeb = doc.css("table").first
		let bodyTable = arrayBody.first
		if(bodyTable == nil || nameTeamWeb == nil){
			return nil
		}
		
		//TODO attenzione alle squadre tipo ac milan
		let arrayNames = nameTeamWeb!["data-sname"]?.componentsSeparatedByString(" v ")
		
		if(arrayNames == nil){
			return nil
		}
		
		let pariDispari = PariDispari()
		
		var countOdd = 0
		for tr in bodyTable!.css("tr, class, data-bname") {
			
			if(!(tr_class(tr["class"]))){
				continue
			}
			
			//Inizializzo il counter per i brand
			countOdd = 0;
			
			for td in tr.css("td, class, data-odig"){
				
				let odd = Odd()
				let a = td["class"]
				let b = td["data-odig"]
				if(a == nil || nameTeamWeb == nil || b == nil){
					continue
				}
				
				//Where to go
				let w = switchHelper(a!, value: b!)
				
				switch(w){
					
				case 1:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
					
				case 2:
					odd.best = true
					odd.brand = self.listOfBrands[countOdd]
					odd.value = td.text!
				case 3:
					odd.best = false
					odd.brand = self.listOfBrands[countOdd]
				default: continue
					
				}
				
				switch(tr["data-bname"]!){
				case "Odd":
					pariDispari.dispari.append(odd)
				case "Even":
					pariDispari.pari.append(odd)
				default: break
				}
				
				//Fine singolo ciclo per coppia quota brand
				countOdd++
				
			}
		}
		
//		print(" ")
//		print("Pari Dispari")
//		print(pariDispari.pari)
//		print(pariDispari.dispari)
		
		return pariDispari
	}
	
	
	func getRankingAndStatisticFromHtml(doc: HTMLDocument)->RankingAndStatistic?{

		var classificaTable: XMLElement?
		
		for table in doc.css("table"){
			if(table["class"] == "big classifica"){
				classificaTable = table
			}
		}
		
		if(classificaTable == nil){
			return nil
		}
		
		let classificaBody = classificaTable?.css("tbody").first
		
		//	print(classificaBody!.toHTML)
		
		if(classificaBody == nil){
			return nil
		}
		
		let ranking = RankingAndStatistic()
		
		for tr in classificaBody!.css("tr"){
			
			var count = 0
			
			let row = RankingRow()
			
			for td in tr.css("td"){
				var base = td.text!
				base = base.stringByReplacingOccurrencesOfString("\n", withString: "")
				base = base.stringByReplacingOccurrencesOfString("\t", withString: "")
				
				switch(count){
				case 0:
					row.pos = base
				case 1:
					break
				case 2:
					row.team = base
				case 3:
					row.punti = base
				case 4:
					row.g = base
				case 5:
					row.v = base
				case 6:
					row.n = base
				case 7:
					row.p = base
				case 8:
					row.gf = base
				case 9:
					row.gs = base
				case 10:
					
					for span in td.css("span"){
						var base2 = span.text!
						base2 = base2.stringByReplacingOccurrencesOfString("\n", withString: "")
						base2 = base2.stringByReplacingOccurrencesOfString("\t", withString: "")
						row.ultimeGiornate.append(base2)
					}
					
					break
				default:
					break
				}
				
				count++
			}
			
			ranking.rankingList.append(row)
			//print(row)
		}
		
	

	
	
	
	
		return ranking
	
	}
	
	
	private func addAllTeamsExceptions(){
		
		//Itaia
		
			//Serie A
			self.dictionaryTeam["Atalanta"] = setNames(["Atalanta"])
			self.dictionaryTeam["Bologna"] = setNames(["Bologna"])
			self.dictionaryTeam["Carpi"] = setNames(["Carpi"])
			self.dictionaryTeam["Chievo"] = setNames(["Chievo"])
			self.dictionaryTeam["Empoli"] = setNames(["Empoli"])
			self.dictionaryTeam["Fiorentina"] = setNames(["Fiorentina"])
			self.dictionaryTeam["Frosinone"] = setNames(["Frosinone"])
			self.dictionaryTeam["Genoa"] = setNames(["Genoa"])
			self.dictionaryTeam["Verona"] = setNames(["Verona"])
			self.dictionaryTeam["Inter"] = setNames(["Inter"])
			self.dictionaryTeam["Juventus"] = setNames(["Juventus"])
			self.dictionaryTeam["Lazio"] = setNames(["Lazio"])
			self.dictionaryTeam["AC Milan"] = setNames(["Milan","AC Milan"])
			self.dictionaryTeam["Napoli"] = setNames(["Napoli"])
			self.dictionaryTeam["Palermo"] = setNames(["Palermo"])
			self.dictionaryTeam["Roma"] = setNames(["Roma"])
			self.dictionaryTeam["Sampdoria"] = setNames(["Sampdoria"])
			self.dictionaryTeam["Sassuolo"] = setNames(["Sassuolo"])
			self.dictionaryTeam["Torino"] = setNames(["Torino"])
			self.dictionaryTeam["Udinese"] = setNames(["Udinese"])
		
		
			//Serie B
			self.dictionaryTeam["Ascoli"] = setNames(["Ascoli"])
			self.dictionaryTeam["Avellino"] = setNames(["Avellino"])
			self.dictionaryTeam["Bari"] = setNames(["Bari"])
			self.dictionaryTeam["Brescia"] = setNames(["Brescia"])
			self.dictionaryTeam["Cagliari"] = setNames(["Cagliari"])
			self.dictionaryTeam["Cesena"] = setNames(["Cesena"])
			self.dictionaryTeam["Como"] = setNames(["Como"])
			self.dictionaryTeam["Crotone"] = setNames(["Crotone"])
			self.dictionaryTeam["Lanciano"] = setNames(["Lanciano"])
			self.dictionaryTeam["Latina"] = setNames(["Latina"])
			self.dictionaryTeam["Livorno"] = setNames(["Livorno"])
			self.dictionaryTeam["Modena"] = setNames(["Modena"])
			self.dictionaryTeam["Novara"] = setNames(["Novara"])
			self.dictionaryTeam["Perugia"] = setNames(["Perugia"])
			self.dictionaryTeam["Entella"] = setNames(["Entella"])
			self.dictionaryTeam["Pro Vercelli"] = setNames(["Pro Vercelli"])
			self.dictionaryTeam["Pescara"] = setNames(["Pescara"])
			self.dictionaryTeam["Spezia"] = setNames(["Spezia"])
			self.dictionaryTeam["Salernitana"] = setNames(["Salernitana"])
			self.dictionaryTeam["Trapani"] = setNames(["Trapani"])
			self.dictionaryTeam["Vicenza"] = setNames(["Vicenza"])
			self.dictionaryTeam["Ternana"] = setNames(["Ternana"])
		
		
		
		
		
		//Spagna
		
		//Liga
			self.dictionaryTeam["Barcelona"] = setNames(["Barcelona","Barcellona"])
			self.dictionaryTeam["Athletic Bilbao"] = setNames(["Athletic Bilbao","Athl Bilbao"])
		
		
		
		//Francia
		
			//League 1
			self.dictionaryTeam["Lyon"] = setNames(["Lyon","Lione"])
			self.dictionaryTeam["Nice"] = setNames(["Nice"])
		
		//Germania
		
		//BundesLiga
			self.dictionaryTeam["Bayern Munich"] = setNames(["Bayern Munich","Bayern Monaco"])
			self.dictionaryTeam["Dortmund"] = setNames(["Bor Dortmund","Dortmund"])
			self.dictionaryTeam["Monchengladbach"] = setNames(["Monchengladbach","Bor Mönchengladbach"])
		
	}
	
	//helper function
	private func setNames(array: [String])->NameTeamWebSite{
		let obj = NameTeamWebSite()
		obj.possibleNames = array
		return obj
	}
	
	private func doubleChanceCase(homeT: String, awayT: String, left: String, right: String)->Int?{
		if( left != "Draw" && right != "Draw"){
			return 2
		}
		
		var check: String?
		
		if(left == "Draw"){
			check = right
		}else{
			check = left
		}
		
		if(homeT == check){
			return 0
		}
		
		if(awayT == check){
			return 1
		}
		
		if (dictionaryTeam[homeT] != nil) {
			if(dictionaryTeam[homeT]!.possibleNames.contains(check!)){
				return 0
			}
		}
		if (dictionaryTeam[awayT] != nil) {
			if(dictionaryTeam[awayT]!.possibleNames.contains(check!)){
				return 1
			}
		}
		
		return nil
	}
	
	private func getFinalResultCase(home: String, away: String, check: String)->Int?{
		if(check == "Pareggio" || check == "Draw"){
			return 1
		}
		
		if(home == check){
			return 0
		}
		
		if(away == check){
			return 2
		}
		
		if (dictionaryTeam[home] != nil) {
			if(dictionaryTeam[home]!.possibleNames.contains(check)){
				return 0
			}
		}
		
		if (dictionaryTeam[away] != nil) {
			if(dictionaryTeam[away]!.possibleNames.contains(check)){
				return 2
			}
		}
		
		return nil
	}
}

class NameTeamWebSite {
	
	var possibleNames = [String]()
}