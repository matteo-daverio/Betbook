//
//  OfflineGraphViewController.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 24/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class OfflineGraphViewController: GraphViewController, UITextFieldDelegate{
	
	@IBOutlet weak var inputBetTextField: HighlightedTextField!
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		createBetField()
		
		self.addDoneButtonOnKeyboard()
	}
	
	func createBetField() {
		
		inputBetTextField.borderStyle = UITextBorderStyle.None
		inputBetTextField.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
		inputBetTextField.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
		inputBetTextField.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
		inputBetTextField.placeholder = "Quota copertura ex: 1.50"
		inputBetTextField.upperPlaceholder = "Quota copertura"
		inputBetTextField.placeholderFontScale = 0.65
		inputBetTextField.keyboardType = UIKeyboardType.DecimalPad
		inputBetTextField.delegate = self
		
	}
	
	
	// Creation of Done button on keyboard
	func addDoneButtonOnKeyboard() {
		
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
		doneToolbar.barStyle = UIBarStyle.BlackTranslucent
		
		let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
		let done: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("doneButtonAction"))
		
		var items = [UIBarButtonItem]()
		items.append(flexSpace)
		items.append(done)
		
		doneToolbar.items = items
		doneToolbar.sizeToFit()
		
		self.inputBetTextField.inputAccessoryView = doneToolbar
		
	}
	
	func doneButtonAction() {
		
		self.inputBetTextField.resignFirstResponder()
		self.brandMultiplier = Double(inputBetTextField.text!.stringByReplacingOccurrencesOfString(",", withString: "."))! - 1.00
		print("ciao")
		self.chart?.view.removeFromSuperview()
		self.updateUI()
		
	}
	
	private func reloadGraph(){
		
	}
	
	
	// Accept only correct number
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		
		switch string {
		case "0","1","2","3","4","5","6","7","8","9":
			var precision = 0
			var foundPoint = 0
			for character in (textField.text?.characters)! {
				if foundPoint == 1 {
					precision++
				}
				if (character == "." || character == ",") {
					foundPoint = 1
				}
			}
			if precision < 2 {
				return true
			} else {
				return false
			}
		case ".":
			if textField.text == "" {
				return false
			}
			for character in (textField.text?.characters)! {
				if (character == "." || character == ",") {
					return false
				}
			}
			return true
		case ",":
			if textField.text == "" {
				return false
			}
			for character in (textField.text?.characters)! {
				if (character == "." || character == ",") {
					return false
				}
			}
			return true
		default:
			return true
		}
	}
}