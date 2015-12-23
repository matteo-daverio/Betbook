//
//  CoverViewController.swift
//  MyApp
//
//  Created by Matteo on 20/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit
import UITextField_Shake


class CoverViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, SBPickerSelectorDelegate, MatchListDelegate {
	
	@IBOutlet weak var scrollView: UIScrollView!
	
    @IBOutlet weak var textFieldBet: HighlightedTextField!
    
    @IBOutlet weak var textFieldVictory: HighlightedTextField!
    
    @IBOutlet weak var selectNation: HighlightedTextField!
	
	private var nationPicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showNationPicker(sender: UIButton) {
		
		//*********************
		//setup here your picker
		//*********************
		
		self.nationPicker.pickerData = self.populateNation() //picker content
		self.nationPicker.delegate = self
		self.nationPicker.pickerType = SBPickerSelectorType.Text
		self.nationPicker.doneButtonTitle = "Done"
		self.nationPicker.cancelButtonTitle = "Cancel"
		
		let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
		var frame: CGRect = sender.frame
		frame.origin = point
		self.nationPicker.showPickerIpadFromRect(frame, inView: view)
		
	}
    
    @IBOutlet weak var selectLeague: HighlightedTextField!
	
	private var leaguePicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showLeaguePicker(sender: UIButton) {
		
		if (!invalidField(selectNation)) {
			// TODO: invalidare match e outcome se selezionato qualcosa di diverso
			
			self.leaguePicker.pickerData = self.populateLeague()
			self.leaguePicker.delegate = self
			self.leaguePicker.pickerType = SBPickerSelectorType.Text
			self.leaguePicker.doneButtonTitle = "Done"
			self.leaguePicker.cancelButtonTitle = "Cancel"
			
			//		let view = self.view
			
			let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
			var frame: CGRect = sender.frame
			frame.origin = point
			
			self.leaguePicker.showPickerIpadFromRect(frame, inView: view)
			
		} else {
			selectNation.shake()
		}
	}
	
	
	@IBOutlet weak var matchListButton: UIButton!
    
    @IBOutlet weak var selectMatch: HighlightedTextField!
	
	private var matchListPicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showMatchList(sender: AnyObject) {
		
		if (!invalidField(selectLeague)) {
			// TODO: invalidare outcome se selezionato qualcosa di diverso
			
			if(self.matches == nil){
				matchListModel.getMatchList(self.selectNation.text!, uiLeague: self.selectLeague.text!)
				spinner.startAnimating()
			}else{
				
				self.spinner.stopAnimating()
				
				self.matchListPicker.delegate = self
				self.matchListPicker.pickerType = SBPickerSelectorType.Text
				self.matchListPicker.doneButtonTitle = "Done"
				self.matchListPicker.cancelButtonTitle = "Cancel"
				
				let sender = self.matchListButton
				
				let point: CGPoint = self.view.convertPoint(sender.frame.origin, fromView: sender.superview)
				var frame: CGRect = sender.frame
				frame.origin = point
				
				self.matchListPicker.showPickerIpadFromRect(frame, inView: self.view)
			}
		
			
			
		} else {
			selectLeague.shake()
		}
		
	}
	
    @IBOutlet weak var selectKindOfBet: HighlightedTextField!
	
	private var kindOfBetPicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showKindOfBetList(sender: UIButton) {
		
		if (!invalidField(selectMatch)) {
			
			
			//*********************
			//setup here your picker
			//*********************
			
			self.kindOfBetPicker.pickerData = self.populateKindOfBet() //picker content
			self.kindOfBetPicker.delegate = self
			self.kindOfBetPicker.pickerType = SBPickerSelectorType.Text
			self.kindOfBetPicker.doneButtonTitle = "Done"
			self.kindOfBetPicker.cancelButtonTitle = "Cancel"
			
			let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
			var frame: CGRect = sender.frame
			frame.origin = point
			self.kindOfBetPicker.showPickerIpadFromRect(frame, inView: view)
			
			
		} else {
			selectMatch.shake()
		}
	}
	
	
	@IBOutlet weak var selectValeOfBet: HighlightedTextField!
	
	private var valueOfBetPicker: SBPickerSelector = SBPickerSelector.picker()
	
	
	@IBAction func showValueOfBet(sender: UIButton) {
		
		if (!invalidField(selectKindOfBet)) {
		
			self.valueOfBetPicker.pickerData = self.populateValueOfBet()
			
			self.valueOfBetPicker.delegate = self
			self.valueOfBetPicker.pickerType = SBPickerSelectorType.Text
			self.valueOfBetPicker.doneButtonTitle = "Done"
			self.valueOfBetPicker.cancelButtonTitle = "Cancel"
			
			let point: CGPoint = view.convertPoint(sender.frame.origin, fromView: sender.superview)
			var frame: CGRect = sender.frame
			frame.origin = point
			self.valueOfBetPicker.showPickerIpadFromRect(frame, inView: view)
			
		} else {
			selectKindOfBet.shake()
		}
	}
	
	
    @IBOutlet weak var calculateButton: MKButton!
	
	let matchListModel = MatchListRequest()
	
	var matches: [Match]?{
		didSet{
			self.matchListPicker.pickerData = populateMatchList()
		}
	}
	
	let spinner = UIActivityIndicatorView(frame: CGRectMake(0,0,100,100))
	
	
	
	
	
    override func viewDidLoad() {
        
        super.viewDidLoad()
		
		//Importantissimo
		matchListModel.delegate = self
		
		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
		spinner.hidesWhenStopped = true
		spinner.transform = CGAffineTransformMakeScale(1.5, 1.5)
		let center = self.view.center
		spinner.center = CGPointMake(center.x, center.y-center.y*0.30)
		spinner.color = UIColor.blackColor()
		spinner.backgroundColor = UIColor.clearColor()
		self.view.addSubview(spinner)
	
		scrollView.scrollEnabled = true
		
		scrollView.contentSize = self.view.frame.size
        
        self.view.backgroundColor = UIColor(red: 248/255, green: 246/255, blue: 246/255, alpha: 1)
        
        createBetField()
        createVictoryField()
        createMatchSelector()
        createButton()
        
        // Add UIToolBar on keyboard and Done button on ToolBar
        self.addDoneButtonOnKeyboard()

        
    }
    
    override func viewDidLayoutSubviews() {
        calculateButton.layer.cornerRadius = 0.5 * calculateButton.bounds.size.width
        //calculateButton.layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).CGColor as CGColorRef
        //calculateButton.layer.borderWidth = 2.0
        //calculateButton.clipsToBounds = true
    }
	
	override func shouldAutorotate() -> Bool {
		return false
	}
	
	override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
		return UIInterfaceOrientationMask.Portrait
	}
	
    /*
	func textFieldDidBeginEditing(textField: UITextField) {
		scrollView.setContentOffset(CGPointMake(0, 300), animated: true)
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		
		textField.resignFirstResponder()
		
		return true
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
	}
    */
    func createBetField() {
        
        //let textFieldFrameBet = CGRect(x: 20, y: screenHeight / 8, width: screenWidth - (2 * 20), height: 40)
        //textFieldBet = HighlightedTextField(frame: textFieldFrameBet)
        
//      textFieldBet.frame = CGRect(x: 20, y: screenHeight / 8, width: screenWidth - (2 * 20), height: 40)
        textFieldBet.borderStyle = UITextBorderStyle.None
        textFieldBet.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        textFieldBet.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        textFieldBet.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        textFieldBet.placeholder = "Somma giocata €    0.00"
        textFieldBet.upperPlaceholder = "Somma giocata €"
        textFieldBet.placeholderFontScale = 0.65
        textFieldBet.keyboardType = UIKeyboardType.DecimalPad
        textFieldBet.delegate = self
        
        //self.view.addSubview(textFieldBet)
        
    }
    
    func createVictoryField() {
        
        //let textFieldFrameVictory = CGRect(x: 20, y: screenHeight / 4, width: screenWidth - (2 * 20), height: 40)
        //textFieldVictory = HoshiTextField(frame: textFieldFrameVictory)
        
        textFieldVictory.borderStyle = UITextBorderStyle.None
        textFieldVictory.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        textFieldVictory.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        textFieldVictory.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        textFieldVictory.placeholder = "Vittoria €    0.00"
        textFieldVictory.upperPlaceholder = "Vittoria €"
        textFieldVictory.keyboardType = UIKeyboardType.DecimalPad
        textFieldVictory.delegate = self
        
        //self.view.addSubview(textFieldVictory)
        
    }
    
    func createMatchSelector() {
        
        createNationSection()
        createLeagueSection()
        createMatchSection()
        createKindOfBetSection()
        createValueOfBetSection()
        
    }
    
    func createButton() {
        
        //let calculateButton = TVButton(frame: CGRect(x: 40, y: 300, width: 80, height: 40))
		
		self.calculateButton.frame.size = CGSize(width: 100, height: 100)
        
        calculateButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        calculateButton.setFAIcon(FAType.FALineChart, iconSize: calculateButton.bounds.size.width/2, forState: .Normal)
        
        calculateButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        calculateButton.maskEnabled = true
        calculateButton.cornerRadius = 40.0
        calculateButton.backgroundLayerCornerRadius = 40.0
        calculateButton.ripplePercent = 1.75
        calculateButton.rippleLocation = .TapLocation
        calculateButton.rippleLayerColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        calculateButton.layer.shadowOpacity = 1
        calculateButton.layer.shadowRadius = 4
        calculateButton.layer.shadowColor = UIColor.blackColor().CGColor
        calculateButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.5)
        
        calculateButton.addTarget(self, action: "calculate:", forControlEvents: .TouchUpInside)
        
        //self.view.addSubview(calculateButton)
        
    }
    
    func createNationSection() {
        
        // TextField Creation
        selectNation.borderStyle = UITextBorderStyle.None
        selectNation.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectNation.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectNation.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectNation.placeholder = "Nazione:    (ex. Italia)"
        selectNation.upperPlaceholder = "Nazione:"
        
//        // Button Creation
//        selectNationButton.addTarget(self, action: "selectNation:", forControlEvents: .TouchUpInside)
		
    }
    
    func createLeagueSection() {
        
        // TextField Creation
        selectLeague.borderStyle = UITextBorderStyle.None
        selectLeague.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectLeague.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectLeague.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectLeague.placeholder = "Campionato:    (ex. Serie A)"
        selectLeague.upperPlaceholder = "Campionato:"
        
//        // Button Creation
//        selectLeagueButton.addTarget(self, action: "selectLeague:", forControlEvents: .TouchUpInside)
		
    }
    
    func createMatchSection() {
        
        // TextField Creation
        selectMatch.borderStyle = UITextBorderStyle.None
        selectMatch.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectMatch.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectMatch.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectMatch.placeholder = "Partita:    (ex. Milan Inter)"
        selectMatch.upperPlaceholder = "Partita:"
        
//        // Button Creation
//        selectMatchButton.addTarget(self, action: "selectMatch:", forControlEvents: .TouchUpInside)
		
    }
    
    func createKindOfBetSection() {
        
        // TextField Creation
        selectKindOfBet.borderStyle = UITextBorderStyle.None
        selectKindOfBet.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectKindOfBet.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectKindOfBet.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectKindOfBet.placeholder = "Tipo di Scommessa:    (ex. Esito Finale)"
        selectKindOfBet.upperPlaceholder = "Tipo di Scommessa:"
        
//        // Button Creation
//        selectOutcomeButton.addTarget(self, action: "selectOutcome:", forControlEvents: .TouchUpInside)
		
    }
    
    func createValueOfBetSection() {
        
        // TextField Creation
        selectValeOfBet.borderStyle = UITextBorderStyle.None
        selectValeOfBet.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectValeOfBet.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectValeOfBet.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectValeOfBet.placeholder = "Risultato:    (ex. 1)"
        selectValeOfBet.upperPlaceholder = "Risultato:"
        
    }
    
    
    
    // button Calculate press
    func calculate(sender: UIButton!) {
        
        if (invalidBetField()) {
            textFieldBet.shake()
            if (invalidVictoryField()) {
                textFieldVictory.shake()
                if (invalidField(selectValeOfBet)) {
                    selectValeOfBet.shake()
                }
            } else {
                if (invalidField(selectValeOfBet)) {
                    selectValeOfBet.shake()
                }
            }
        } else {
            if (invalidVictoryField()) {
                textFieldVictory.shake()
                if (invalidField(selectValeOfBet)) {
                    selectValeOfBet.shake()
                }
            } else {
                if (invalidField(selectValeOfBet)) {
                    selectValeOfBet.shake()
                } else {
                    
                    // valid input
                    // save data into model, initialize all classes and go to next view
                    
                }
            }
        }
    }
    
    
    // invalid fields
    
    func invalidBetField() -> Bool {
        if (textFieldBet.text == "") {
            return true
        }
        return false
    }
    
    func invalidVictoryField() -> Bool {
        if (textFieldVictory.text == "") {
            return true
        }
        return false
    }
    
    func invalidField(field: UITextField) -> Bool {
        if (field.text == "") {
            return true
        }
        return false
    }
	
	func setMatchList(matchList: [Match]?){
		
		dispatch_async(dispatch_get_main_queue()){ () -> Void in
			if( matchList == nil ){
				print("Match non disponibili")
			}else{
				self.matches = matchList!
				self.spinner.stopAnimating()
				
				self.matchListPicker.delegate = self
				self.matchListPicker.pickerType = SBPickerSelectorType.Text
				self.matchListPicker.doneButtonTitle = "Done"
				self.matchListPicker.cancelButtonTitle = "Cancel"
				
				let sender = self.matchListButton
				
				let point: CGPoint = self.view.convertPoint(sender.frame.origin, fromView: sender.superview)
				var frame: CGRect = sender.frame
				frame.origin = point
				
				self.matchListPicker.showPickerIpadFromRect(frame, inView: self.view)
				
			}
		}
		
	}
	
	
	//MARK: SBPickerSelectorDelegate
	func pickerSelector(selector: SBPickerSelector!, selectedValue value: String!, index idx: Int) {
		
		switch(selector){
		case self.nationPicker:
			self.selectNation.text = value
		case self.leaguePicker:
			self.selectLeague.text = value
		case self.matchListPicker:
			self.selectMatch.text = value
		case self.kindOfBetPicker:
			self.selectKindOfBet.text = value
		case self.valueOfBetPicker:
			self.selectValeOfBet.text = value
		default: break
		}
	}

	
	
	
	/////////////
	
	private func populateNation() -> [String]{
		return StringForTheWebHelper().getAvailableCountry()
	}
	
	private func populateLeague() -> [String]{
			return StringForTheWebHelper().getAvailableLague(self.selectNation.text!)
	}
	
	private func populateMatchList() -> [String]{
		
		var listOfMatches = [String]()
		
		for m in self.matches! {
			listOfMatches.append(m.homeTeam! + " " + m.awayTeam!)
		}
		
		return listOfMatches
	}
	
	private func populateKindOfBet() -> [String]{
		return StringForTheWebHelper().getAvailableOutcome()
	}
	
	private func populateValueOfBet() -> [String]{
		return StringForTheWebHelper().getAvailableValueForKindOfBet(self.selectKindOfBet.text!)
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
        
        self.textFieldBet.inputAccessoryView = doneToolbar
        self.textFieldVictory.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction() {
        
        self.textFieldBet.resignFirstResponder()
        self.textFieldVictory.resignFirstResponder()
        
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
                if character == "." {
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
                if character == "." {
                    return false
                }
            }
            return true
        default:
            return true
        }
        
    }

}
