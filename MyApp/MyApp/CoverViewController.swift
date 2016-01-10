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
	
	private var online: Bool = true
	
	private var match: Match?
	
	@IBOutlet weak var switchOnline: IGSwitch!
	
	@IBOutlet weak var scrollView: UIScrollView!
	
    @IBOutlet weak var textFieldBet: HighlightedTextField!
    
    @IBOutlet weak var textFieldVictory: HighlightedTextField!
    
	@IBOutlet weak var selectNation: HighlightedTextField!
	
	private var nationPicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showNationPicker(sender: UIButton) {
        if online == true {
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
		
	}
    
    @IBOutlet weak var selectLeague: HighlightedTextField!
	
	private var leaguePicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showLeaguePicker(sender: UIButton) {
		
        if online == true {
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
		
	}
	
	
	@IBOutlet weak var matchListButton: UIButton!
    
    @IBOutlet weak var selectMatch: HighlightedTextField!
	
	private var matchListPicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showMatchList(sender: AnyObject) {
		
        if online == true {
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
                if (invalidField(selectNation)) {
                    selectNation.shake()
                }
            }
        }
	}
	
    @IBOutlet weak var selectKindOfBet: HighlightedTextField!
	
	private var kindOfBetPicker: SBPickerSelector = SBPickerSelector.picker()
	
	@IBAction func showKindOfBetList(sender: UIButton) {
		
        if online == true {
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
                if (invalidField(selectLeague)) {
                    selectLeague.shake()
                    if (invalidField(selectNation)) {
                        selectNation.shake()
                    }
                }
            }
        }
        
	}
	
	
	@IBOutlet weak var selectValeOfBet: HighlightedTextField!
	
	private var valueOfBetPicker: SBPickerSelector = SBPickerSelector.picker()
	
	
	@IBAction func showValueOfBet(sender: UIButton) {
		
        if online == true {
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
                if (invalidField(selectMatch)) {
                    selectMatch.shake()
                    if (invalidField(selectLeague)) {
                        selectLeague.shake()
                        if (invalidField(selectNation)) {
                            selectNation.shake()
                        }
                    }
                }
            }
        }
        
	}
	
	
    @IBOutlet weak var calculateButton: MKButton!
	
	let matchListModel = MatchListRequest()
	
	var matches: [Match]?{
		didSet{
			if(matches != nil){
				self.matchListPicker.pickerData = populateMatchList()
			}
		}
	}
	
	let spinner = UIActivityIndicatorView(frame: CGRectMake(0,0,100,100))
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@IBAction func goToGraph(sender: MKButton) {
		
		if(switchOnline.selectedIndex == 0){
			online = true
		}else{
			online = false
		}
		
		if(isValidOffline()){
			performSegueWithIdentifier("showOfflineGraphMVC", sender: self)
		}
		
		if(isValidOnline()){
			performSegueWithIdentifier("showOnlineGraphMVC", sender: self)
		}
		
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "showOnlineGraphMVC"){
			let upcoming: OnlineGraphViewController = segue.destinationViewController as! OnlineGraphViewController
			upcoming.bettingAmount = Double((self.textFieldBet.text?.stringByReplacingOccurrencesOfString(",", withString: "."))!)
			upcoming.potentialWinning = Double((self.textFieldVictory.text?.stringByReplacingOccurrencesOfString(",", withString: "."))!)
			upcoming.brandMultiplier = Double("0.0")
			upcoming.homeTeam = self.match?.homeTeam!
			upcoming.awayTeam = self.match?.awayTeam!
			upcoming.nation = self.selectNation.text!
			upcoming.league = self.selectLeague.text!
			
			let cover = CoverageCalculator(esito: self.selectKindOfBet.text!, giocata: self.selectValeOfBet.text!).calculateCoverage()
			
			upcoming.kindOfBet = cover.0
			upcoming.valueOfBet = cover.1
		}
		
		if(segue.identifier == "showOfflineGraphMVC"){
			let upcoming: OfflineGraphViewController = segue.destinationViewController as! OfflineGraphViewController
			upcoming.bettingAmount = Double((self.textFieldBet.text?.stringByReplacingOccurrencesOfString(",", withString: "."))!)
			upcoming.potentialWinning = Double((self.textFieldVictory.text?.stringByReplacingOccurrencesOfString(",", withString: "."))!)
			upcoming.brandMultiplier = Double("0.0")
		}
		
	}
	
	private func isValidOnline() -> Bool {
		if(online &&
			!self.invalidField(self.textFieldBet) &&
			!self.invalidField(self.textFieldVictory) &&
			!self.invalidField(self.selectNation) &&
			!self.invalidField(self.selectLeague) &&
			!self.invalidField(self.selectMatch) &&
			!self.invalidField(self.selectKindOfBet) &&
			!self.invalidField(self.selectValeOfBet)
			){
				return true
		}
		
		return false
	}
	
	private func isValidOffline() -> Bool {
		if(!online &&
			!self.invalidField(self.textFieldBet) &&
			!self.invalidField(self.textFieldVictory)){
				return true
		}
		
		return false
	}
	
	
	
	
	
	
	
	
	
	
	
    override func viewDidLoad() {
        
        super.viewDidLoad()
		
		//Importantissimo
		matchListModel.delegate = self
		
		self.scrollView.scrollEnabled = false
		
		self.title = "Coverage"
		
		spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
		spinner.hidesWhenStopped = true
		spinner.transform = CGAffineTransformMakeScale(1.5, 1.5)
		let center = self.view.center
		spinner.center = CGPointMake(center.x, center.y-center.y*0.30)
		spinner.color = UIColor.blackColor()
		spinner.backgroundColor = UIColor.clearColor()
		self.view.addSubview(spinner)
	
		//scrollView.scrollEnabled = true
		
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
        
        calculateButton.setFAIcon(FAType.FALineChart, iconSize: calculateButton.bounds.size.width * 0.58, forState: .Normal)
        //calculateButton.layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).CGColor as CGColorRef
        //calculateButton.layer.borderWidth = 2.0
        //calculateButton.clipsToBounds = true
		createSwitch()
    }
    
    func createSwitch() {
        
        // QUI BISOGNA INIZIALIZZARLO E POSIZIONARLO
        // AD ESEMPIO:   switchOnline = IGSwitch(frame: <#T##CGRect#>)
        // SE FAI LA ACTION, IL VALORE è DATO DALL'INDEX, AD ESEMPIO:
		
		if (switchOnline.selectedIndex == 0) {
			self.online = true
        } else {
			self.online = false
        }
		
        switchOnline.titleLeft = "Online"
        switchOnline.titleRight = "Offline"
        switchOnline.sliderColor = UIColor.whiteColor()
        switchOnline.sliderInset = 2
        switchOnline.cornerRadius = 10
        switchOnline.backgroundColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        switchOnline.textColorFront = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        switchOnline.textColorBack = UIColor.whiteColor()
        
        switchOnline.addTarget(self, action: "switchChange:", forControlEvents: .ValueChanged)
        
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
    
    // switch change values
    func switchChange(sender: IGSwitch!) {
        
        if (switchOnline.selectedIndex == 0) {
            self.online = true
        } else {
            self.online = false
        }
        
        if online == true {
            // mettere a posto input field
            
        } else {
            // mettere input field grigi
            
        }
        
    }
    
    // button Calculate press
    func calculate(sender: UIButton!) {
        
        if online == true {
            if (invalidBetField()) {
                textFieldBet.shake()
                textFieldBet.invalidInput()
                if (invalidVictoryField()) {
                    textFieldVictory.shake()
                    textFieldVictory.invalidInput()
                    if (invalidField(selectValeOfBet)) {
                        selectValeOfBet.shake()
                        selectValeOfBet.invalidInput()
                        if (invalidField(selectKindOfBet)) {
                            selectKindOfBet.shake()
                            selectKindOfBet.invalidInput()
                            if (invalidField(selectMatch)) {
                                selectMatch.shake()
                                selectMatch.invalidInput()
                                if (invalidField(selectLeague)) {
                                    selectLeague.shake()
                                    selectLeague.invalidInput()
                                    if (invalidField(selectNation)) {
                                        selectNation.shake()
                                        selectNation.invalidInput()
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (invalidField(selectValeOfBet)) {
                        selectValeOfBet.shake()
                        selectValeOfBet.invalidInput()
                        if (invalidField(selectKindOfBet)) {
                            selectKindOfBet.shake()
                            selectKindOfBet.invalidInput()
                            if (invalidField(selectMatch)) {
                                selectMatch.shake()
                                selectMatch.invalidInput()
                                if (invalidField(selectLeague)) {
                                    selectLeague.shake()
                                    selectLeague.invalidInput()
                                    if (invalidField(selectNation)) {
                                        selectNation.shake()
                                        selectNation.invalidInput()
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if (invalidVictoryField()) {
                    textFieldVictory.shake()
                    textFieldVictory.invalidInput()
                    if (invalidField(selectValeOfBet)) {
                        selectValeOfBet.shake()
                        selectValeOfBet.invalidInput()
                        if (invalidField(selectKindOfBet)) {
                            selectKindOfBet.shake()
                            selectKindOfBet.invalidInput()
                            if (invalidField(selectMatch)) {
                                selectMatch.shake()
                                selectMatch.invalidInput()
                                if (invalidField(selectLeague)) {
                                    selectLeague.shake()
                                    selectLeague.invalidInput()
                                    if (invalidField(selectNation)) {
                                        selectNation.shake()
                                        selectNation.invalidInput()
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (invalidField(selectValeOfBet)) {
                        selectValeOfBet.shake()
                        selectValeOfBet.invalidInput()
                        if (invalidField(selectKindOfBet)) {
                            selectKindOfBet.shake()
                            selectKindOfBet.invalidInput()
                            if (invalidField(selectMatch)) {
                                selectMatch.shake()
                                selectMatch.invalidInput()
                                if (invalidField(selectLeague)) {
                                    selectLeague.shake()
                                    selectLeague.invalidInput()
                                    if (invalidField(selectNation)) {
                                        selectNation.shake()
                                        selectNation.invalidInput()
                                    }
                                }
                            }
                        }
                    } else {
                        
                        // valid input
                        // save data into model, initialize all classes and go to next view
                        
                    }
                }
            }

        } else {
            if invalidBetField() {
                textFieldBet.shake()
                textFieldBet.invalidInput()
                if (invalidVictoryField()) {
                    textFieldVictory.shake()
                    textFieldVictory.invalidInput()
                }
            } else {
                if (invalidVictoryField()) {
                    textFieldVictory.shake()
                    textFieldVictory.invalidInput()
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
            if (selectNation.text != value) {
                self.selectNation.text = value
                self.selectLeague.text = ""
                self.selectMatch.text = ""
                self.selectKindOfBet.text = ""
                self.selectValeOfBet.text = ""
				self.matches = nil
				self.match = nil
            }
        case self.leaguePicker:
            if (selectLeague.text != value) {
                self.selectLeague.text = value
                self.selectMatch.text = ""
                self.selectKindOfBet.text = ""
                self.selectValeOfBet.text = ""
				self.matches = nil
				self.match = nil
            }
        case self.matchListPicker:
            if (selectMatch.text != value) {
                self.selectMatch.text = value
                self.selectKindOfBet.text = ""
                self.selectValeOfBet.text = ""
				self.match = self.matches![idx]
            }
        case self.kindOfBetPicker:
            if (selectKindOfBet.text != value) {
                self.selectKindOfBet.text = value
                self.selectValeOfBet.text = ""
            }
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
