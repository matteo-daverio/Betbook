//
//  OddsViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 09/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit
import CollapsableTable

class OddsViewController: CollapsableTableViewController, OddsMatchDelegate{
	
	// MARK: - Property
	
	@IBOutlet weak var tableView: UITableView!
	
	let menu = OddsModelBuilder().buildMenu()
	let oddsHttpRequester = OddsMatchHttpRequest()
	
	var brandPosition: Int?
	
	var brand: String?
	var homeTeam: String?
	var awayTeam: String?
	var selectedCountryOrEuropeanCompetition: String?
	var selectedLeague: String?
	
	var numberOfAvailableOdds = OddsModelBuilder().getNumberOfBrand()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.brandPosition = 1
		oddsHttpRequester.delegate = self
		
		//	self.brandPosition = ParserHtml().getIndexOfBrand(brand!)
		//	oddsHttpRequester.homeTeam = homeTeam!
		oddsHttpRequester.homeTeam = "Genoa"
		//	oddsHttpRequester.awayTeam = awayTeam!
		oddsHttpRequester.awayTeam = "Bologna"
		//  oddsHttpRequester.selectedCountryOrEuropeanCompetition = selectedCountryOrEuropeanCompetition!
		oddsHttpRequester.selectedCountryOrEuropeanCompetition = "italia"
		//  oddsHttpRequester.selectedLeague = selectedLeague!
		oddsHttpRequester.selectedLeague = "serie-a"
		
		
		//Odds for the final result
		oddsHttpRequester.getOddsRisultatoFinaleForMatch()
		
		//Odds for the final result half time
		oddsHttpRequester.getOddsRisultatoFinalePrimoTempoForMatch()
		
		//Odds for the doppia chance
		oddsHttpRequester.getOddsDoppiaChanceForMatch()
	
		//Odds for under and Over
		oddsHttpRequester.getOddsUnderOverForMatch()

		//Odds for gol no gol
		oddsHttpRequester.getOddsGolNoGolForMatch()
		
		//Odds for gol no gol primo tempo
		oddsHttpRequester.getOddsGolNoGolPrimoTempoForMatch()

		//Odds for gol no gol secondo tempo
		oddsHttpRequester.getOddsGolNoGolSecondoTempoForMatch()
		
		//Odds for odd or even
		oddsHttpRequester.getOddsPariDispariForMatch()
		
	}
	override func model() -> [CollapsableTableViewSectionModelProtocol]? {
		return menu
	}
	
	override func sectionHeaderNibName() -> String? {
		return "OddsMenuSectionHeaderView"
	}
	
	override func singleOpenSelectionOnly() -> Bool {
		return true
	}
	
	override func collapsableTableView() -> UITableView? {
		return tableView
	}
	
	
	
	// MARK: - OddsDelegate
	
	func setRisultatoFinale(risultatoFinale: RisultatoFinale?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(risultatoFinale != nil){
				let itemsEsitoFinale = self.menu[0].items as! [Item]
				let itemsValue = risultatoFinale?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsEsitoFinale.count ; i++){
					itemsEsitoFinale[i].val = itemsValue![i]
				}
			}
				self.tableView.reloadData()
			
			
		}
	}
	
	func setRisultatoFinalePrimoTempo(risultatoFinalePrimoTempo: RisultatoFinale?){
		
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(risultatoFinalePrimoTempo != nil){
				let itemsEsitoFinalePrimoTempo = self.menu[1].items as! [Item]
				let itemsValue = risultatoFinalePrimoTempo?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsEsitoFinalePrimoTempo.count ; i++){
					itemsEsitoFinalePrimoTempo[i].val = itemsValue![i]
				}
			}
				self.tableView.reloadData()
		}
	}
	
	func setDoppiaChance(doppiaChance: DoppiaChance?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(doppiaChance != nil){
				let itemsDoppiaChance = self.menu[2].items as! [Item]
				let itemsValue = doppiaChance?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsDoppiaChance.count ; i++){
					itemsDoppiaChance[i].val = itemsValue![i]
				}
			}
			self.tableView.reloadData()
		}
		
	}
	
	func setUnderOver(underOver: UnderOver?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(underOver != nil){
				let itemsUnderOver = self.menu[3].items as! [Item]
				let itemsValue = underOver?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsUnderOver.count ; i++){
					itemsUnderOver[i].val = itemsValue![i]
				}
			}
			self.tableView.reloadData()
			
		}
	}
	
	func setGolNoGol(golNoGol: GolNoGol?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(golNoGol != nil){
				let itemsGolNoGol = self.menu[4].items as! [Item]
				let itemsValue = golNoGol?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsGolNoGol.count ; i++){
					itemsGolNoGol[i].val = itemsValue![i]
				}
			}
			print("Ciao")
			self.tableView.reloadData()
		}
	}
	
	func setGolNoGolPrimoTempo(golNoGolPrimoTempo: GolNoGol?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(golNoGolPrimoTempo != nil){
				let itemsGolNoGolPrimoTempo = self.menu[5].items as! [Item]
				let itemsValue = golNoGolPrimoTempo?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsGolNoGolPrimoTempo.count ; i++){
					itemsGolNoGolPrimoTempo[i].val = itemsValue![i]
				}
			}
			self.tableView.reloadData()
		}
	}
	
	func setGolNoGolSecondoTempo(golNoGolSecondoTempo: GolNoGol?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(golNoGolSecondoTempo != nil){
				let itemsGolNoGolSecondoTempo = self.menu[6].items as! [Item]
				let itemsValue = golNoGolSecondoTempo?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsGolNoGolSecondoTempo.count ; i++){
					itemsGolNoGolSecondoTempo[i].val = itemsValue![i]
				}
			}
			self.tableView.reloadData()
		}
	}
	
	func setPariDispari(pariDispari: PariDispari?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(pariDispari != nil){
				let itemsPariDispari = self.menu[7].items as! [Item]
				let itemsValue = pariDispari?.flatArrayGivenTheBrandIndex(self.brandPosition!)
				var i = 0
				for(; i < itemsPariDispari.count ; i++){
					itemsPariDispari[i].val = itemsValue![i]
				}
			}
			self.tableView.reloadData()
		}
	}
}


extension OddsViewController {
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 44.0
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44.0
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier("OddCell")! as UITableViewCell
		
		let betItem = menu[indexPath.section].items[indexPath.row] as! Item
		
		
		cell.textLabel?.text = betItem.name!
		cell.detailTextLabel?.text = betItem.val!
		
		return cell
	}
}