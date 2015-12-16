//
//  BetViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 14/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class BetViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var pickerView: AKPickerView!
	
	@IBOutlet weak var tableView: UITableView!
	
	@IBAction func addOtherMatch(sender: UIBarButtonItem) {
		(self.tabBarController as! RAMAnimatedTabBarController).setSelectIndex(from: TabBarEnum.Bet.rawValue, to: TabBarEnum.Search.rawValue )
	}
	 var listOfBet = [Bet]()
	
	private var selectedBrand:String?
	
	let titles = ["BetClick.it", "Bwin", "William Hill", "GazzaBet", "Iziplay",
		"Unibet", "NetBet", "Bet-At-Home", "PaddyPower", "Sisal", "BetFlag", "Sport Yes", "Eurobet", "Betfair", "Lottomatica", "Totosi"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.selectedBrand = titles[0]
		
		self.pickerView.delegate = self
		self.pickerView.dataSource = self
		
		self.tableView.registerNib(UINib(nibName: "BetTableViewCell", bundle: nil), forCellReuseIdentifier: "BetCell")
		
		self.pickerView.interitemSpacing = 20.0
		self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
		self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
		self.pickerView.pickerViewStyle = .Wheel
		self.pickerView.maskDisabled = true
		
		self.pickerView.reloadData()
		self.tableView.reloadData()
	}
	
	override func viewWillAppear(animated: Bool) {
		self.tableView.reloadData()
	}
	
	// MARK: - AKPickerViewDataSource
	
	func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
		return self.titles.count
	}
	
	/*
	
	Image Support
	-------------
	Please comment '-pickerView:titleForItem:' entirely and
	uncomment '-pickerView:imageForItem:' to see how it works.
	
	*/
	func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
		return self.titles[item]
	}
	
	func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
		return UIImage(named: self.titles[item])!
	}
	
	// MARK: - AKPickerViewDelegate
	
	func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
		self.selectedBrand = "\(self.titles[item])"
	}
	
	/*
	
	Label Customization
	-------------------
	You can customize labels by their any properties (except for fonts,)
	and margin around text.
	These methods are optional, and ignored when using images.
	
	*/
	
	/*
	func pickerView(pickerView: AKPickerView, configureLabel label: UILabel, forItem item: Int) {
	label.textColor = UIColor.lightGrayColor()
	label.highlightedTextColor = UIColor.whiteColor()
	label.backgroundColor = UIColor(
	hue: CGFloat(item) / CGFloat(self.titles.count),
	saturation: 1.0,
	brightness: 0.5,
	alpha: 1.0)
	}
	
	func pickerView(pickerView: AKPickerView, marginForItem item: Int) -> CGSize {
	return CGSizeMake(40, 20)
	}
	*/
	
	/*
	
	UIScrollViewDelegate Support
	----------------------------
	AKPickerViewDelegate inherits UIScrollViewDelegate.
	You can use UIScrollViewDelegate methods
	by simply setting pickerView's delegate.
	
	*/
	
	private func checkSameBrand(bet: Bet) -> Bool {
		
		for b in listOfBet {
			if(b.brand! != bet.brand!){
				return false
			}
		}
		
		return true
	}
	
	private func isAlreadyIn(bet: Bet) -> Bool {
		
		for b in listOfBet {
			
			if( b.homeTeam! == bet.homeTeam && b.awayTeam! == bet.awayTeam! && b.date! == bet.date!){
				return true
			}
		}
		
		return false
	}
	
	 func tryAddThisMatchEvent(bet: Bet) -> Bool {
		
		if(checkSameBrand(bet) && !isAlreadyIn(bet)){
			self.listOfBet.append(bet)
			if(self.tableView != nil){
				self.tableView.reloadData()
			}
			return true
		}
		
		return false
	}
	
	// MARK: - UITableViewDataSource
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("BetCell", forIndexPath: indexPath) as! BetTableViewCell
		
		// Configure the cell..
		
		let bet = listOfBet[indexPath.row]
		
		cell.bet = bet
		
		return cell

	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listOfBet.count
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		
		return 87
	}
	
	
	// MARK: - UITableViewDelegate
	
	
	
}