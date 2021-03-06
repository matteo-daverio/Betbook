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
	
	let spinner = UIActivityIndicatorView(frame: CGRectMake(0,0,100,100))
	
	var delegate: UIViewController?
	
	let menu = OddsModelBuilder().buildMenu()
	let oddsHttpRequester = OddsMatchHttpRequest()
	var stringForTheWebHelper = StringForTheWebHelper()
	var selectedColor = UIColor(red: 0.00/255.0, green: 255.00/255.0, blue: 127.00/255.0, alpha: 1.00)
	
	var myBetControllerNavigator: UINavigationController?
	var myBetController: BetViewController?
	
	var brandPosition: Int?
	
	var brand: String?{
		didSet{
			self.brandPosition = stringForTheWebHelper.giveIndexOfTheBrand(self.brand!)
		}
	}
	var homeTeam: String!
	var awayTeam: String!
	var selectedCountryOrEuropeanCompetition: String!
	var selectedLeague: String!
	var match: Match!
	
	var numberOfAvailableOdds = OddsModelBuilder().getNumberOfBrand()
	
	override func viewWillAppear(animated: Bool) {
		self.tableView.reloadData()
		print(self.tableView.contentSize)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
//		self.myBetControllerNavigator = self.tabBarController?.viewControllers![TabBarEnum.Bet.rawValue] as? UINavigationController
//		
//		self.myBetController = self.myBetControllerNavigator!.viewControllers[0] as? BetViewController
		
		//Importantissimo
		self.tableView.allowsSelection = false
		self.tableView.allowsMultipleSelection = false
		self.tableView.tableFooterView = UIView(frame: CGRect.zero)
		
		self.oddsHttpRequester.homeTeam = self.homeTeam
		self.oddsHttpRequester.awayTeam = self.awayTeam
		self.oddsHttpRequester.selectedCountryOrEuropeanCompetition = self.selectedCountryOrEuropeanCompetition
		self.oddsHttpRequester.selectedLeague = self.selectedLeague
		
		let bounds = UIScreen.mainScreen().bounds
		let widht = bounds.size.width
		let height = bounds.size.height
		
		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
		spinner.hidesWhenStopped = true
		spinner.transform = CGAffineTransformMakeScale(1.5, 1.5)
		let center = CGPoint(x: widht * 0.5, y: height * 0.2)
		
		
		
		spinner.center = CGPointMake(center.x, center.y)
		spinner.color = UIColor.blackColor()
		spinner.backgroundColor = UIColor.clearColor()
		self.view.addSubview(spinner)
		self.view.bringSubviewToFront(spinner)
		spinner.startAnimating()
		
		self.delegate?.reloadInputViews()
		
		self.tableView.registerNib(UINib(nibName: "OddsTableViewCell", bundle: nil), forCellReuseIdentifier: "OddCell")
		
		oddsHttpRequester.delegate = self
		
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

			self.spinner.stopAnimating()
			self.tableView.allowsSelection = true
			self.tableView.reloadData()
		}
	}
}


extension OddsViewController{
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 44.0
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44.0
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let cell = tableView.cellForRowAtIndexPath(indexPath) as! OddsTableViewCell
		
		if(cell.detailTextLabel?.text == "n.d."){
			self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
			return
		}
			
			let myBetControllerNavigator = self.tabBarController?.viewControllers![TabBarEnum.Bet.rawValue] as! UINavigationController
		
			let myBetController = myBetControllerNavigator.viewControllers[0] as! BetViewController
		
		
			let kindOfBet = menu[indexPath.section].title
			let betItem = (menu[indexPath.section].items[indexPath.row]) as! Item
		
			let bet = Bet(homeTeam: self.match.homeTeam!, awayTeam: self.match.awayTeam!, date: self.match.date!, hour: self.match.hour!, league: self.match.league!, country: self.match.country!, kindOfBet: kindOfBet, bet: betItem.name!, betValue: betItem.val!, brand: self.brand!)
		if(!myBetController.isAlreadyIn(bet)){
		
			if(myBetController.tryAddThisMatchEvent(bet)){
				cell.contentView.backgroundColor = self.selectedColor
			}else{
				let title = "Attenzione!"
				let message = "Non è possibile comporre una scommessa con brand differenti"
				let okText = "Ok"
				
				let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
				
				let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Cancel, handler: nil)
				
				alert.addAction(okayButton)
				self.presentViewController(alert, animated: true, completion: nil)
				
			}
		}else{
			myBetController.removeThisBet(bet)
			cell.contentView.backgroundColor = UIColor.whiteColor()
		}
		
		
		
		tableView.reloadData()
	}
	
//	func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
//		let cell = tableView.cellForRowAtIndexPath(indexPath) as! OddsTableViewCell
//	
//		cell.backgroundView?.backgroundColor = UIColor.greenColor()
//		
//	}
	
//	func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//		let cell = tableView.cellForRowAtIndexPath(indexPath) as! OddsTableViewCell
//		
//		cell.backgroundView?.backgroundColor = UIColor.greenColor()
//	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier("OddCell")! as UITableViewCell
		
		let betItem = menu[indexPath.section].items[indexPath.row] as! Item
		
		//Prova
		
		let arrayBet = myBetController!.listOfBet
		
		var cellGreen = false
		
		let kindOfBet = menu[indexPath.section].title
		let bet = betItem.name!
		
		for b in arrayBet {
			if( b.homeTeam! == self.homeTeam &&
				b.awayTeam == self.awayTeam  &&
				b.date == self.match.date!   &&
				b.kindOfBet! == kindOfBet    &&
				b.bet! == bet                &&
				b.brand! == self.brand!){
				cellGreen = true
					break
			}
		}
		
		if(cellGreen){
			cell.backgroundColor = self.selectedColor
		}else{
			cell.backgroundColor = UIColor.whiteColor()
			cell.backgroundView?.backgroundColor = UIColor.whiteColor()
		}
		
		cell.textLabel?.text = betItem.name!
		cell.detailTextLabel?.text = betItem.val!
		
//		cell.backgroundColor = UIColor.greenColor()
		
		
		return cell
	}
}