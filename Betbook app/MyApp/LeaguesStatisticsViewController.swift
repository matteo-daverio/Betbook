//
//  LeaguesStatisticsViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 30/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class LeaguesStatisticsViewController: UIViewController {
	
	var pageMenu : CAPSPageMenu?
	
	private func helperController(var league: String) -> RankingAndStatsticViewController{
		let controller = RankingAndStatsticViewController()
		controller.league = league
		if(league == "Premier League"){
			league = "Premier L."
		}
		controller.title = league
		return controller
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// MARK: - UI Setup
		
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
		
		
		controllerArray.append(helperController("Serie A"))
		controllerArray.append(helperController("Premier League"))
		controllerArray.append(helperController("Liga"))
		controllerArray.append(helperController("Ligue 1"))
		controllerArray.append(helperController("Bundesliga"))
		
		//Questi saranno i controller ognuno con le quote associate al suo brand
		
//		let betClickController = helperFunctionInitializeController("BetClick.it", selectedCountryOrEuropeanCompetition: self.selectedCountryOrEuropeanCompetition!, selectedLeague: self.selectedLeague, homeTeam: self.homeTeam, awayTeam: self.awayTeam, match: self.match)
//		controllerArray.append(betClickController)
//		
//		
		
		
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
		
		self.title = "Standings"
		
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