//
//  MatchOddsViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 09/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit
class MatchOddsViewController: UIViewController {

	var pageMenu : CAPSPageMenu?
	var homeTeam: String!
	var awayTeam: String!
	var selectedCountryOrEuropeanCompetition: String!
	var selectedLeague: String!
	
	private func helperFunctionInitializeController(brand: String,selectedCountryOrEuropeanCompetition: String, selectedLeague: String, homeTeam: String, awayTeam: String) -> OddsViewController{
		
		let viewController = OddsViewController()
		viewController.title = brand
		viewController.brand = brand
		viewController.selectedCountryOrEuropeanCompetition = selectedCountryOrEuropeanCompetition
		viewController.selectedLeague = selectedLeague
		viewController.homeTeam = homeTeam
		viewController.awayTeam = awayTeam
		viewController.delegate = self
		
		return viewController
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		// MARK: - UI Setup
		
		self.title = homeTeam.capitalizedString + "  " + awayTeam.capitalizedString
		self.navigationController?.navigationBar.translucent = false
		self.navigationController?.navigationBar.barTintColor = UIColor(red: 20.0/255.0, green: 29.0/255.0, blue: 74.0/255.0, alpha: 1.0)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
		self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
		self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
//		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: "didTapGoToLeft")
//		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "->", style: UIBarButtonItemStyle.Done, target: self, action: "didTapGoToRight")
		
		// MARK: - Scroll menu setup
		
		// Initialize view controllers to display and place in array
		var controllerArray : [UIViewController] = []
		
		//Questi saranno i controller ognuno con le quote associate al suo brand
		
		let betClickController = helperFunctionInitializeController("BetClick.it", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(betClickController)
		
		let bwinController = helperFunctionInitializeController("Bwin", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(bwinController)
		
		let wHillController = helperFunctionInitializeController("William Hill", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(wHillController)
		
		let gazzaController = helperFunctionInitializeController("GazzaBet", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(gazzaController)
		
		let iziPController = helperFunctionInitializeController("Iziplay", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(iziPController)
		
		let uniBController = helperFunctionInitializeController("Unibet", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(uniBController)
		
		let netBController = helperFunctionInitializeController("NetBet", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(netBController)
		
		let bahController = helperFunctionInitializeController("Bet-At-Home", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(bahController)
		
		let paddyPController = helperFunctionInitializeController("PaddyPower", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(paddyPController)
		
		let sisalController = helperFunctionInitializeController("Sisal Matchpoint", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(sisalController)
		
		let betFController = helperFunctionInitializeController("BetFlag", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(betFController)
		
		let sportYController = helperFunctionInitializeController("Sport Yes", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(sportYController)
		
		let euroBController = helperFunctionInitializeController("Eurobet", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(euroBController)
		
		let betFairController = helperFunctionInitializeController("Betfair", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(betFairController)
		
		let LottomaticaController = helperFunctionInitializeController("Lottomatica", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(LottomaticaController)
		
		let totoController = helperFunctionInitializeController("Totosi", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam)
		controllerArray.append(totoController)
		
	
		
		// Customize menu (Optional)
		let parameters: [CAPSPageMenuOption] = [
			.ScrollMenuBackgroundColor(UIColor(red: 20.0/255.0, green: 29.0/255.0, blue: 74.0/255.0, alpha: 1.0)),
			.ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 29.0/255.0, blue: 74.0/255.0, alpha: 1.0)),
			.SelectionIndicatorColor(UIColor.whiteColor()),
			.BottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 29.0/255.0, blue: 74.0/255.0, alpha: 1.0)),
			.MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
			.MenuHeight(40.0),
			.MenuItemWidth(90.0),
			.CenterMenuItems(true)
		]
		
		// Initialize scroll menu
		pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
		
		self.addChildViewController(pageMenu!)
		self.view.addSubview(pageMenu!.view)
		
		pageMenu!.didMoveToParentViewController(self)
	}
	
	func didTapGoToLeft() {
		let currentIndex = pageMenu!.currentPageIndex
		
		if currentIndex > 0 {
			pageMenu!.moveToPage(currentIndex - 1)
		}
	}
	
	func didTapGoToRight() {
		let currentIndex = pageMenu!.currentPageIndex
		
		if currentIndex < pageMenu!.controllerArray.count {
			pageMenu!.moveToPage(currentIndex + 1)
		}
	}
	
	// MARK: - Container View Controller
	override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
		return true
	}
	
	override func shouldAutomaticallyForwardRotationMethods() -> Bool {
		return true
	}
	
}
