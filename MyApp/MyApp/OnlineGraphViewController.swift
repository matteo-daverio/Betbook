//
//  OnlineGraphViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 23/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//


import UIKit

class OnlineGraphViewController: GraphViewController, AKPickerViewDataSource, AKPickerViewDelegate,OddsMatchDelegate {

	@IBOutlet weak var brandPicker: AKPickerView!

	let brands = StringForTheWebHelper().getBrandsList()
	
	let oddsHttpRequester = OddsMatchHttpRequest()
	var stringForTheWebHelper = StringForTheWebHelper()
	
	var match: Match?
	var nation: String?
	var league: String?
	var homeTeam: String?
	var awayTeam: String?
	var kindOfBet: String?
	var valueOfBet: String?
	
	var risultatoFinale: RisultatoFinale?
	var doppiaChance: DoppiaChance?
	var underOver: UnderOver?
	var golNoGol: GolNoGol?
	var golNoGolPrimoTempo: GolNoGol?
	var golNoGolSecondoTempo: GolNoGol?
	var pariDispari: PariDispari?
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		self.nation = stringForTheWebHelper.dictionaryOfCountryOrEuropeanCompetition[nation!]!
		self.league = stringForTheWebHelper.dictionaryOfLeagues[league!]!
		
		self.brandPicker.delegate = self
		self.brandPicker.dataSource = self

		self.brandPicker.interitemSpacing = 20.0
		self.brandPicker.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
		self.brandPicker.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
		self.brandPicker.pickerViewStyle = .Wheel
		self.brandPicker.maskDisabled = true
		
		self.brandPicker.reloadData()
		
		oddsHttpRequester.delegate = self
		oddsHttpRequester.selectedCountryOrEuropeanCompetition = nation!
		oddsHttpRequester.selectedLeague = league!
		oddsHttpRequester.homeTeam = homeTeam!
		oddsHttpRequester.awayTeam = awayTeam!
		
		downloadOdds()
	}
	
	private func downloadOdds(){
		
		switch(self.kindOfBet!){
			case "Esito Finale":
				oddsHttpRequester.getOddsRisultatoFinaleForMatch()
			case "Doppia Chance":
				oddsHttpRequester.getOddsDoppiaChanceForMatch()
			case "Under/Over 0.5":
				oddsHttpRequester.getOddsUnderOverForMatch()
			case "Under/Over 1.5":
				oddsHttpRequester.getOddsUnderOverForMatch()
			case "Under/Over 2.5":
				oddsHttpRequester.getOddsUnderOverForMatch()
			case "Under/Over 3.5":
				oddsHttpRequester.getOddsUnderOverForMatch()
			case "Under/Over 4.5":
				oddsHttpRequester.getOddsUnderOverForMatch()
			case "Gol/No Gol":
				oddsHttpRequester.getOddsGolNoGolForMatch()
			case "Primo Tempo Gol/No Gol":
				oddsHttpRequester.getOddsGolNoGolPrimoTempoForMatch()
			case "Secondo Tempo Gol/No Gol":
				oddsHttpRequester.getOddsGolNoGolSecondoTempoForMatch()
			case "Pari/Dispari":
				oddsHttpRequester.getOddsPariDispariForMatch()
		default:
				break
		}
		
	}
	
	
	
	
	// MARK: - OddsDelegate
	
	func setRisultatoFinale(risultatoFinale: RisultatoFinale?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(risultatoFinale != nil){
				self.risultatoFinale = risultatoFinale
				self.pickerView(self.brandPicker, didSelectItem: self.brandPicker.selectedItem)
			}
		}
	}
	
	func setRisultatoFinalePrimoTempo(risultatoFinalePrimoTempo: RisultatoFinale?){
		
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(risultatoFinalePrimoTempo != nil){
				
			}
		}
	}
	
	func setDoppiaChance(doppiaChance: DoppiaChance?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(doppiaChance != nil){
				self.doppiaChance = doppiaChance
				self.pickerView(self.brandPicker, didSelectItem: self.brandPicker.selectedItem)
			}
		}
	}
	
	func setUnderOver(underOver: UnderOver?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(underOver != nil){
				self.underOver = underOver
				self.pickerView(self.brandPicker, didSelectItem: self.brandPicker.selectedItem)
			}
		}
	}
	
	func setGolNoGol(golNoGol: GolNoGol?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(golNoGol != nil){
				self.golNoGol = golNoGol
				self.pickerView(self.brandPicker, didSelectItem: self.brandPicker.selectedItem)
			}
		}
	}
	
	func setGolNoGolPrimoTempo(golNoGolPrimoTempo: GolNoGol?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(golNoGolPrimoTempo != nil){
				self.golNoGolPrimoTempo = golNoGolPrimoTempo
				self.pickerView(self.brandPicker, didSelectItem: self.brandPicker.selectedItem)
			}
		}
	}
	
	func setGolNoGolSecondoTempo(golNoGolSecondoTempo: GolNoGol?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(golNoGolSecondoTempo != nil){
				self.golNoGolSecondoTempo = golNoGolSecondoTempo
				self.pickerView(self.brandPicker, didSelectItem: self.brandPicker.selectedItem)
			}
		}
	}
	
	func setPariDispari(pariDispari: PariDispari?){
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if(pariDispari != nil){
				self.pariDispari = pariDispari
				self.pickerView(self.brandPicker, didSelectItem: self.brandPicker.selectedItem)
			}
		}
	}
	
	
	// MARK: - AKPickerViewDataSource
	
	func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
		return self.brands.count
	}
	
	/*
	
	Image Support
	-------------
	Please comment '-pickerView:titleForItem:' entirely and
	uncomment '-pickerView:imageForItem:' to see how it works.
	
	*/
	func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
		return self.brands[item]
	}
	
	func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
		return UIImage(named: self.brands[item])!
	}
	
	// MARK: - AKPickerViewDelegate
	
	func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
		print("\(self.brands[item])")
		
		switch(self.kindOfBet!){
		case "Esito Finale":
			switch(self.valueOfBet!){
			case "1":
				if(self.risultatoFinale != nil){
					let multiplier = risultatoFinale?.home[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "X":
				if(self.risultatoFinale != nil){
					let multiplier = risultatoFinale?.tie[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "2":
				if(self.risultatoFinale != nil){
					let multiplier = risultatoFinale?.away[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Doppia Chance":
			switch(self.valueOfBet!){
			case "1X":
				if(self.doppiaChance != nil){
					let multiplier = doppiaChance?.unoX[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "X2":
				if(self.doppiaChance != nil){
					let multiplier = doppiaChance?.xDue[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
				break
			case "12":
				if(self.doppiaChance != nil){
					let multiplier = doppiaChance?.unoDue[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Under/Over 0.5":
			switch(self.valueOfBet!){
			case "Over":
				if(self.underOver != nil){
					let multiplier = underOver?.over0_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "Under":
				if(self.underOver != nil){
					let multiplier = underOver?.under0_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Under/Over 1.5":
			switch(self.valueOfBet!){
			case "Over":
				if(self.underOver != nil){
					let multiplier = underOver?.over1_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "Under":
				if(self.underOver != nil){
					let multiplier = underOver?.under1_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Under/Over 2.5":
			switch(self.valueOfBet!){
			case "Over":
				if(self.underOver != nil){
					let multiplier = underOver?.over2_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "Under":
				if(self.underOver != nil){
					let multiplier = underOver?.under2_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Under/Over 3.5":
			switch(self.valueOfBet!){
			case "Over":
				if(self.underOver != nil){
					let multiplier = underOver?.over3_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "Under":
				if(self.underOver != nil){
					let multiplier = underOver?.under3_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Under/Over 4.5":
			switch(self.valueOfBet!){
			case "Over":
				if(self.underOver != nil){
					let multiplier = underOver?.over4_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "Under":
				if(self.underOver != nil){
					let multiplier = underOver?.under4_5[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Gol/No Gol":
			switch(self.valueOfBet!){
			case "Gol":
				if(self.golNoGol != nil){
					let multiplier = golNoGol?.gol[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
					self.brandMultiplier = Double((multiplier?.value)!)
				}
				self.chart?.view.removeFromSuperview()
				self.updateUI()
				}
			case "No Gol":
				if(self.golNoGol != nil){
					let multiplier = golNoGol?.noGol[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Primo Tempo Gol/No Gol":
			switch(self.valueOfBet!){
			case "Gol":
				if(self.golNoGolPrimoTempo != nil){
					let multiplier = golNoGol?.gol[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "No Gol":
				if(self.golNoGol != nil){
					let multiplier = golNoGol?.noGol[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Secondo Tempo Gol/No Gol":
			switch(self.valueOfBet!){
			case "Gol":
				if(self.golNoGolSecondoTempo != nil){
					let multiplier = golNoGol?.gol[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "No Gol":
				if(self.golNoGol != nil){
					let multiplier = golNoGol?.noGol[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		case "Pari/Dispari":
			switch(self.valueOfBet!){
			case "Pari":
				if(self.pariDispari != nil){
					let multiplier = pariDispari?.pari[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			case "Dispari":
				if(self.pariDispari != nil){
					let multiplier = pariDispari?.dispari[item]
					if(multiplier?.value == ""){
						self.brandMultiplier = 0.0
					}else{
						self.brandMultiplier = Double((multiplier?.value)!)
					}
					self.chart?.view.removeFromSuperview()
					self.updateUI()
				}
			default:
				break
			}
		default:
			break
		}
	}

	
}