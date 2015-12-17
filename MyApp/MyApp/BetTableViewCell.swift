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
	
	
	@IBAction func deleteBet() {
		self.delegate?.removeThisBet(self.bet!)
	}
	
	var delegate: BetViewController?
	
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
		
		self.dateHourLabel.text = ((bet?.date)!.uppercaseString) + "  " + (bet?.hour)!
		self.teamsLabel.text = (bet?.homeTeam!.uppercaseString)! + " - " + (bet?.awayTeam!.uppercaseString)!
		self.kindOfBetLabel.text = (bet?.kindOfBet!)! + ":"
		self.betLabel.text = (bet?.bet!.uppercaseString)
		self.betValueLabel.text = (bet?.betValue!.uppercaseString)
	
	}
	
	

}
