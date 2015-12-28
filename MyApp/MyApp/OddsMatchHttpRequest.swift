//
//  OddsMatchHttpRequest.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 10/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation
// Nella cartella del progetto digita: carthage update --platform iOS
import Kanna

protocol OddsMatchDelegate {
	//Gives back to the delegate the list of match scheduled

	func setRisultatoFinale(risultatoFinale: RisultatoFinale?)
	func setRisultatoFinalePrimoTempo(risultatoFinalePrimoTempo: RisultatoFinale?)
	func setDoppiaChance(doppiaChance: DoppiaChance?)
	func setUnderOver(underOver: UnderOver?)
	func setGolNoGol(golNoGol: GolNoGol?)
	func setGolNoGolPrimoTempo(golNoGolPrimoTempo: GolNoGol?)
	func setGolNoGolSecondoTempo(golNoGolSecondoTempo: GolNoGol?)
    func setPariDispari(pariDispari: PariDispari?)
}

class OddsMatchHttpRequest {
	
	
	//Property
	var delegate: OddsMatchDelegate?
	
	private var parserHtml = ParserHtml()
	
	var homeTeam: String!
	
	var awayTeam: String!
	
	//ForTheWeb
	var selectedCountryOrEuropeanCompetition: String!
	
	var selectedLeague: String!
	
	//Base path to achieve the http request
	private let basePath = "http://www.confrontaquote.it/calcio"
	
	//Helper string
	private let slash = "/"
	
	//Helper to get Strings of the model
	private let stringHelper = StringForTheWebHelper()
	
	
	
	func getOddsRisultatoFinaleForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Esito Finale")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var risultatoFinale: RisultatoFinale?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				risultatoFinale = self.parserHtml.getRisultatoFinaleFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setRisultatoFinale(risultatoFinale)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsRisultatoFinalePrimoTempoForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Primo Tempo")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var risultatoFinalePrimoTempo: RisultatoFinale?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				risultatoFinalePrimoTempo = self.parserHtml.getRisultatoFinaleFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setRisultatoFinalePrimoTempo(risultatoFinalePrimoTempo)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsDoppiaChanceForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Doppia Chance")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var doppiaChance: DoppiaChance?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				doppiaChance = self.parserHtml.getDoppiaChanceFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setDoppiaChance(doppiaChance)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	
	func getOddsUnderOverForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Under/Over")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var underOver: UnderOver?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				underOver = self.parserHtml.getUnderOverFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setUnderOver(underOver)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsGolNoGolForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Gol/No Gol")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var golNoGol: GolNoGol?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				golNoGol = self.parserHtml.getGolNoGolFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setGolNoGol(golNoGol)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsGolNoGolPrimoTempoForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Primo Tempo Gol/No Gol")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
				
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var golNoGolPrimoTempo: GolNoGol?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				golNoGolPrimoTempo = self.parserHtml.getGolNoGolFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setGolNoGolPrimoTempo(golNoGolPrimoTempo)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsGolNoGolSecondoTempoForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Secondo Tempo Gol/No Gol")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var golNoGol: GolNoGol?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				golNoGol = self.parserHtml.getGolNoGolFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setGolNoGolSecondoTempo(golNoGol)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	func getOddsPariDispariForMatch(){
		
		let kindOfBet = stringHelper.getKindOfBet("Pari/Dispari")
		let match = homeTeam!.lowercaseString + "-" + awayTeam!.lowercaseString
		
		let path = basePath + slash + selectedCountryOrEuropeanCompetition! + slash + selectedLeague! + slash + match + slash + kindOfBet!
		
		let url = NSURL(string: path)
		
		let session = NSURLSession.sharedSession()
		
		let task = session.dataTaskWithURL(url!) { (data: NSData?, respons: NSURLResponse?, error: NSError?) -> Void in
			
			var pariDispari: PariDispari?
			
			if let doc = Kanna.HTML(html: data!, encoding: NSUTF8StringEncoding) {
				pariDispari = self.parserHtml.getPariDispariFromHtml(doc)
			}
			
						if self.delegate != nil{
			
							//Questa istruzione serve per mettere questa istruzione in esecuzione sulla coda principale! Cosi la grafica viene aggiornata aapena i dati sono disponibili
							//Questo va fatto per evitare ulteriori ritardi nel fornire i dati alla grafica con il delegate
							dispatch_async(dispatch_get_main_queue(), { () -> Void in
								self.delegate?.setPariDispari(pariDispari)
							})
						}
		}
		
		//serve per avviare il task
		task.resume()
	}
	
	
}