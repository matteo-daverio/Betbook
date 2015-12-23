//
//  OnlineGraphViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 23/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//


import UIKit

class OnlineGraphViewController: GraphViewController, AKPickerViewDataSource, AKPickerViewDelegate {

	@IBOutlet weak var brandPicker: AKPickerView!

	let brands = StringForTheWebHelper().getBrandsList()

	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		self.brandPicker.delegate = self
		self.brandPicker.dataSource = self

		self.brandPicker.interitemSpacing = 20.0
		self.brandPicker.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
		self.brandPicker.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
		self.brandPicker.pickerViewStyle = .Wheel
		self.brandPicker.maskDisabled = true
		
		self.brandPicker.reloadData()
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
	}

}