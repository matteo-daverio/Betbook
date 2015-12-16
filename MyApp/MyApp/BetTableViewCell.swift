//
//  BetTableViewCell.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 14/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class BetTableViewCell: UITableViewCell {	
	
	@IBOutlet weak var leagueImage: UIImageView!
	
	@IBOutlet weak var dateHourLabel: UILabel!
	
	@IBOutlet weak var teamsLabel: UILabel!
	
	@IBOutlet weak var kindOfBetLabel: UILabel!
	
	@IBOutlet weak var betLabel: UILabel!
		
	@IBOutlet weak var betValueLabel: UILabel!
	
	var bet: Bet? {
		didSet{
			updateUI()
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func updateUI(){
		
		self.leagueImage.image = UIImage(named: (bet?.league)!)
		
		if(leagueImage.image == nil){
			leagueImage.image = UIImage(named: "default")
		}
		
		self.dateHourLabel.text = ((bet?.date)!.capitalizedString) + "  " + (bet?.hour)!
		self.teamsLabel.text = (bet?.homeTeam!.capitalizedString)! + " vs " + (bet?.awayTeam!.capitalizedString)!
		self.kindOfBetLabel.text = bet?.kindOfBet!
		self.betLabel.text = bet?.bet!
		self.betValueLabel.text = bet?.betValue!
	
	}
	
	

}
