//
//  RankingAndStatsticCellTableViewCell.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 30/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

class RankingAndStatsticCellTableViewCell: UITableViewCell {

	@IBOutlet weak var positionLabel: UILabel!
	
	@IBOutlet weak var teamImageView: UIImageView!
	
	@IBOutlet weak var teamNameLabel: UILabel!
	
	@IBOutlet weak var pointLabel: UILabel!
	
	@IBOutlet weak var history1ImageView: UIImageView!
	
	@IBOutlet weak var history2ImageView: UIImageView!
	
	@IBOutlet weak var history3ImageView: UIImageView!
	
	@IBOutlet weak var history4ImageView: UIImageView!
	
	@IBOutlet weak var history5ImageView: UIImageView!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
