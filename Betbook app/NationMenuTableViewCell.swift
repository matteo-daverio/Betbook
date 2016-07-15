//
//  NationMenuTableViewCell.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 11/01/16.
//  Copyright © 2016 CimboMatte. All rights reserved.
//

import UIKit

class NationMenuTableViewCell: UITableViewCell {

	
	@IBOutlet weak var leagueImage: UIImageView!
	
	@IBOutlet weak var leagueLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
