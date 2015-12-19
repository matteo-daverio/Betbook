//
//  BetEngineTableViewCell.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 16/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class BetEngineTableViewCell: UITableViewCell, SBPickerSelectorDelegate {
	
	@IBOutlet weak var importoLabel: UILabel!
	
	@IBAction func showInputPicker(sender: UIButton) {
		
		
		//*********************
		//setup here your picker
		//*********************
		
		let picker: SBPickerSelector = SBPickerSelector.picker()
		
		picker.pickerData = self.populateInput() //picker content
		picker.delegate = self
		picker.pickerType = SBPickerSelectorType.Text
		picker.doneButtonTitle = "Done"
		picker.cancelButtonTitle = "Cancel"
		
		
		
		//		picker.pickerType = SBPickerSelectorType.Date //select date(needs implements delegate method with date)
		//        picker.datePickerType = SBPickerSelectorDateType.OnlyMonthAndYear
		//		picker.minYear = 2015
		//		picker.maxYear = 2051
		
		
		//        picker.showPickerOver(self)
		
		let view = self.delegate!.view
		
		let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
		var frame: CGRect = sender.frame
		frame.origin = point
		picker.showPickerIpadFromRect(frame, inView: view)

	}
	@IBOutlet weak var quotaTotaleLabel: UILabel!
	
	@IBOutlet weak var vincitaPotenzialeLabel: UILabel!
	
	@IBAction func showBonusPicker(sender: UIButton) {
		
		//*********************
		//setup here your picker
		//*********************
		
		let picker: SBPickerSelector = SBPickerSelector.picker()
		
		picker.pickerData = self.populateBonus() //picker content
		picker.delegate = self
		picker.pickerType = SBPickerSelectorType.Text
		picker.doneButtonTitle = "Done"
		picker.cancelButtonTitle = "Cancel"
		
		
		
		//		picker.pickerType = SBPickerSelectorType.Date //select date(needs implements delegate method with date)
		//        picker.datePickerType = SBPickerSelectorDateType.OnlyMonthAndYear
		//		picker.minYear = 2015
		//		picker.maxYear = 2051
		
		
		//        picker.showPickerOver(self)
		
		let view = self.delegate!.view
		
		let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
		var frame: CGRect = sender.frame
		frame.origin = point
		picker.showPickerIpadFromRect(frame, inView: view)
	}
	
	@IBOutlet weak var bonusLabel: UILabel!
	
	var delegate: BetViewController?
	
	private let betEngine = BetEngine()
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	//MARK: SBPickerSelectorDelegate
	func pickerSelector(selector: SBPickerSelector!, selectedValue value: String!, index idx: Int) {
		
		if((value.componentsSeparatedByString(" ")[1] == "€")){
			importoLabel.text = (value.componentsSeparatedByString(" "))[0]
		}else{
			bonusLabel.text = (value.componentsSeparatedByString(" "))[0]
		}
		
		updateUI()
	}
	
	
	private func populateInput() -> [String]{
		
		var input = [String]()
		
		var base = 2.00
		let increment = 0.50
		
		input.append(String(format: "%.2f", base ) + " €")
		
		for(var i = 0; i < 4998 ; i++ ){
			input.append(String(format: "%.2f", (base + increment)) + " €")
			base = base + increment
		}
		
		return input
	}
	
	private func populateBonus() -> [String]{
		
		var input = [String]()
		
		var base = 5.00
		let increment = 1.00
		
		input.append(String(format: "%.2f", 0.00 ) + " %")
		input.append(String(format: "%.2f", base ) + " %")
		
		for(var i = 0; i < 195 ; i++ ){
			input.append(String(format: "%.2f", (base + increment)) + " %")
			base = base + increment
		}
		return input
	}
	
		func updateUI(){
		
		let computedStructure = self.betEngine.calculateOutput(importoLabel.text!, bonuS: bonusLabel.text!, giocate: delegate!.listOfBet)
		
		self.quotaTotaleLabel.text = (String(format: "%.2f",computedStructure.quotaTotale))
		self.vincitaPotenzialeLabel.text = (String(format: "%.2f", computedStructure.vincitaPotenziale))
		
	}
}

