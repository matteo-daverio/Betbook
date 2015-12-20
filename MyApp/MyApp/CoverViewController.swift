//
//  CoverViewController.swift
//  MyApp
//
//  Created by Matteo on 20/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit
import UITextField_Shake


class CoverViewController: UIViewController {
    
    @IBOutlet weak var textFieldBet: HighlightedTextField!
    
    @IBOutlet weak var textFieldVictory: HighlightedTextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var selectNation: HighlightedTextField!
    
    @IBOutlet weak var selectNationButton: UIButton!
    
    @IBOutlet weak var selectLeague: HighlightedTextField!
    
    @IBOutlet weak var selectLeagueButton: UIButton!
    
    @IBOutlet weak var selectMatch: HighlightedTextField!
    
    @IBOutlet weak var selectMatchButton: UIButton!
    
    @IBOutlet weak var selectOutcome: HighlightedTextField!
    
    @IBOutlet weak var selectOutcomeButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 248/255, green: 246/255, blue: 246/255, alpha: 1)
        
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        
        createBetField(screenWidth, screenHeight: screenHeight)
        createVictoryField(screenWidth, screenHeight: screenHeight)
        createMatchSelector(screenWidth, screenHeight: screenHeight)
        createButton(screenWidth, screenHeight: screenHeight)
        
    }
    
    func createBetField(screenWidth: CGFloat, screenHeight: CGFloat) {
        
        //let textFieldFrameBet = CGRect(x: 20, y: screenHeight / 8, width: screenWidth - (2 * 20), height: 40)
        //textFieldBet = HighlightedTextField(frame: textFieldFrameBet)
        
        textFieldBet.frame = CGRect(x: 20, y: screenHeight / 8, width: screenWidth - (2 * 20), height: 40)
        textFieldBet.borderStyle = UITextBorderStyle.None
        textFieldBet.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        textFieldBet.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        textFieldBet.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        textFieldBet.placeholder = "Somma giocata €    0.00"
        textFieldBet.upperPlaceholder = "Somma giocata €"
        
        //self.view.addSubview(textFieldBet)
        
    }
    
    func createVictoryField(screenWidth: CGFloat, screenHeight: CGFloat) {
        
        //let textFieldFrameVictory = CGRect(x: 20, y: screenHeight / 4, width: screenWidth - (2 * 20), height: 40)
        //textFieldVictory = HoshiTextField(frame: textFieldFrameVictory)
        
        textFieldVictory.borderStyle = UITextBorderStyle.None
        textFieldVictory.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        textFieldVictory.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        textFieldVictory.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        textFieldVictory.placeholder = "Vittoria €    0.00"
        textFieldVictory.upperPlaceholder = "Vittoria €"
        
        //self.view.addSubview(textFieldVictory)
        
    }
    
    func createMatchSelector(screenWidth: CGFloat, screenHeight: CGFloat) {
        
        createNationSection()
        createLeagueSection()
        createMatchSection()
        createOutcomeSection()
        
    }
    
    func createButton(screenWidth: CGFloat, screenHeight: CGFloat) {
        
        //let calculateButton = TVButton(frame: CGRect(x: 40, y: 300, width: 80, height: 40))
        
        calculateButton.backgroundColor = UIColor.redColor()
        //let background = TVButtonLayer(image: UIImage(named: "")!)
        //let pattern = TVButtonLayer(image: UIImage(named: "")!)
        //let top = TVButtonLayer(image: UIImage(named: "")!)
        //button.layers = [background, pattern, top]
        //calculateButton.parallaxIntensity = 1.3
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
        
        // Button Creation
        selectNationButton.addTarget(self, action: "selectNation:", forControlEvents: .TouchUpInside)
        
    }
    
    func createLeagueSection() {
        
        // TextField Creation
        selectLeague.borderStyle = UITextBorderStyle.None
        selectLeague.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectLeague.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectLeague.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectLeague.placeholder = "Campionato:    (ex. Serie A)"
        selectLeague.upperPlaceholder = "Campionato:"
        
        // Button Creation
        selectLeagueButton.addTarget(self, action: "selectLeague:", forControlEvents: .TouchUpInside)
        
    }
    
    func createMatchSection() {
        
        // TextField Creation
        selectMatch.borderStyle = UITextBorderStyle.None
        selectMatch.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectMatch.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectMatch.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectMatch.placeholder = "Partita:    (ex. Milan - Inter)"
        selectMatch.upperPlaceholder = "Partita:"
        
        // Button Creation
        selectMatchButton.addTarget(self, action: "selectMatch:", forControlEvents: .TouchUpInside)
        
    }
    
    func createOutcomeSection() {
        
        // TextField Creation
        selectOutcome.borderStyle = UITextBorderStyle.None
        selectOutcome.borderInactiveColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        selectOutcome.borderActiveColor = UIColor(red: 90/255, green: 190/255, blue: 246/255, alpha: 1)
        selectOutcome.placeholderColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        selectOutcome.placeholder = "Risultato:    (ex. 1)"
        selectOutcome.upperPlaceholder = "Risultato:"
        
        // Button Creation
        selectOutcomeButton.addTarget(self, action: "selectOutcome:", forControlEvents: .TouchUpInside)
        
    }
    
    
    
    
    // button SelectNation press
    func selectNation(sender: UIButton!) {
        // TODO: invalidare league, match e outcome se selezionato qualcosa di diverso
    }
    
    // button selectLeague press
    func selectLeague(sender: UIButton!) {
        
        if (!invalidField(selectNation)) {
            // TODO: invalidare match e outcome se selezionato qualcosa di diverso
        } else {
            selectNation.shake()
        }
        
    }
    
    // button selectMatch press
    func selectMatch(sender: UIButton!) {
        
        if (!invalidField(selectLeague)) {
            // TODO: invalidare outcome se selezionato qualcosa di diverso
        } else {
            selectLeague.shake()
        }
        
    }
    
    // button selectOutcome press
    func selectOutcome(sender: UIButton!) {
        
        if (!invalidField(selectMatch)) {
            
        } else {
            selectMatch.shake()
        }
        
    }
    
    // button Calculate press
    func calculate(sender: UIButton!) {
        
        if (invalidBetField()) {
            textFieldBet.shake()
            if (invalidVictoryField()) {
                textFieldVictory.shake()
                if (invalidField(selectOutcome)) {
                    selectOutcome.shake()
                }
            } else {
                if (invalidField(selectOutcome)) {
                    selectOutcome.shake()
                }
            }
        } else {
            if (invalidVictoryField()) {
                textFieldVictory.shake()
                if (invalidField(selectOutcome)) {
                    selectOutcome.shake()
                }
            } else {
                if (invalidField(selectOutcome)) {
                    selectOutcome.shake()
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
    
}
