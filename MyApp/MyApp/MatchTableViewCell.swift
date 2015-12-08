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
	

	func updateUI(){
		homeTeamName?.text = match?.homeTeam!
		awayTeamName?.text = match?.awayTeam!
		homeImageView.image = UIImage(named: (match?.homeTeam!.lowercaseString)!)
		awayImageView.image = UIImage(named: (match?.awayTeam!.lowercaseString)!)
	}
}
