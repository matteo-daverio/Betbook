//
//  MatchTableViewCell.swift
//  CocoaPods
//
//  Created by Alessandro Cimbelli on 03/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

	var match : Match? {
		didSet{
			updateUI()
		}
	}
	
	@IBOutlet weak var homeTeamName: UILabel!

	@IBOutlet weak var awayTeamName: UILabel!

	
	@IBOutlet weak var homeImageView: UIImageView!
	
	@IBOutlet weak var awayImageView: UIImageView!
	
	@IBOutlet weak var hourLabel: UILabel!

	func updateUI(){
		homeTeamName?.text = match?.homeTeam!
		awayTeamName?.text = match?.awayTeam!
		hourLabel?.text = match?.hour!
		
		var homeImageName = match?.homeTeam!.stringByReplacingOccurrencesOfString("ö", withString: "o")
		homeImageName = homeImageName!.stringByReplacingOccurrencesOfString("á", withString: "a")
		
		var awayImageName = match?.awayTeam!.stringByReplacingOccurrencesOfString("ö", withString: "o")
		awayImageName = awayImageName!.stringByReplacingOccurrencesOfString("á", withString: "a")
		
		homeImageView.image = UIImage(named: homeImageName!.lowercaseString)
		
		if(homeImageView.image == nil){
			homeImageView.image = UIImage(named: "default")
		}
		
		awayImageView.image = UIImage(named: awayImageName!.lowercaseString)
		
		if(awayImageView.image == nil){
			awayImageView.image = UIImage(named: "default")
		}
	}
}
