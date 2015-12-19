//
//  BetViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 14/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class BetViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate, UITableViewDataSource, UITableViewDelegate{

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
		
		self.tableView.tableFooterView = UIView(frame: CGRect.zero)
		self.selectedBrand = titles[0]
		
		self.tableView.backgroundColor = UIColor(red: 215.0/255.0, green: 227.0/255.0, blue: 244.0/255.0, alpha: 1.0)
		self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
		self.tableView.separatorColor = UIColor.clearColor()
		
		
		self.pickerView.delegate = self
		self.pickerView.dataSource = self
		self.tableView.allowsSelection = false
		
		self.tableView.registerNib(UINib(nibName: "BetTableViewCell", bundle: nil), forCellReuseIdentifier: "BetCell")
		
		self.tableView.registerNib(UINib(nibName: "BetEngineTableViewCell", bundle: nil),forCellReuseIdentifier: "EngineBetCell")
		
		self.pickerView.interitemSpacing = 20.0
		self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
		self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
		self.pickerView.pickerViewStyle = .Wheel
		self.pickerView.maskDisabled = true
		
		self.pickerView.reloadData()
		
		self.tableView.reloadData()
	}
	
	override func viewWillAppear(animated: Bool) {
		if(listOfBet.count > 0){

			for(var i = 0; i < listOfBet.count ; i++){
				if(listOfBet[0].brand! == titles[i]){
					print(listOfBet[0].brand!)
					print(titles[i])
					pickerView.scrollToItem(i)
					pickerView.scrollToItem(i, animated: true)
					pickerView.selectItem(i, animated: true)
					pickerView.reloadData()
				}
			}
		}
		self.tableView.reloadData()
	}
	
	private func updateCalculus(){
		
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
	
	private func ifIsAlreadyInUpdate(bet: Bet) -> Bool {
		
		for(var i = 0; i < listOfBet.count; i++) {
			let b = listOfBet[i]
			if( b.homeTeam! == bet.homeTeam && b.awayTeam! == bet.awayTeam! && b.date! == bet.date!){
				b.kindOfBet = bet.kindOfBet!
				b.bet = bet.bet!
				b.betValue = bet.betValue!
				return true
			}
		}
		return false
	}
	
	func isAlreadyIn(bet: Bet) -> Bool {
		for(var i = 0; i < listOfBet.count; i++) {
			let b = listOfBet[i]
		
			if( b.homeTeam! == bet.homeTeam &&
				b.awayTeam! == bet.awayTeam! &&
				b.date! == bet.date! &&
				b.kindOfBet == bet.kindOfBet! &&
				b.bet == bet.bet!){
					return true
			
			}
		}
		return false
	}
	
	 func tryAddThisMatchEvent(bet: Bet) -> Bool {
		
		if(!checkSameBrand(bet)){
			return false
		}
		
		if(ifIsAlreadyInUpdate(bet)){
		
			if(self.tableView != nil){
					self.tableView.reloadData()
				}
			
			return true
		
		}else{
			
			self.listOfBet.append(bet)
			
			if(self.tableView != nil){
				self.tableView.reloadData()
			
			}
			
			self.updateCalculus()
			
			return true
		}
	}
	
	func removeThisBet(bet: Bet) -> Bool{
		for(var i = 0; i < listOfBet.count; i++) {
			let b = listOfBet[i]
			if(b.homeTeam! == bet.homeTeam && b.awayTeam! == bet.awayTeam! && b.date! == bet.date!){
				listOfBet.removeAtIndex(i)
				self.tableView.reloadData()
				return true
			}
		}
		return false
	}
	
	// MARK: - UITableViewDataSource
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		if( indexPath.row != tableView.numberOfRowsInSection(indexPath.section) - 1){
			let cell = tableView.dequeueReusableCellWithIdentifier("BetCell", forIndexPath: indexPath) as! BetTableViewCell
			
			// Configure the cell
			let bet = listOfBet[indexPath.row]
			cell.bet = bet
			cell.delegate = self
			cell.backgroundColor = UIColor.clearColor()
			return cell
		}else{
			
			let cell = tableView.dequeueReusableCellWithIdentifier("EngineBetCell", forIndexPath: indexPath) as! BetEngineTableViewCell
			cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0)
			cell.backgroundColor = UIColor.clearColor()
			cell.delegate = self
			cell.updateUI()
			
			return cell
		}
	}
	
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(listOfBet.count > 0){
			return self.listOfBet.count + 1
		}else{
			return 0
		}
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if( indexPath.row < listOfBet.count){
			return 71
		}else{
			return 156
		}
	}
	
	
	// MARK: - UITableViewDelegate
	
	
	
}