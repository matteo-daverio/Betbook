//
//  LeaderboardTableViewCell.swift
//  MyApp
//
//  Created by Matteo on 30/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//


import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var history1: UIImageView!
    @IBOutlet weak var history2: UIImageView!
    @IBOutlet weak var history3: UIImageView!
    @IBOutlet weak var history4: UIImageView!
    @IBOutlet weak var history5: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    /*
    func updateUI() {
        
        rankLabel?.text = leaderboard?.rankLabel
        teamNameLabel?.text = leaderboard?.teamNameLabel
        pointsLabel?.text = leaderboard?.pointsLabel
        /*teamImage.image = UIImage(named: (leaderboard?.teamNameLabel.lowercaseString)!)
        
        if (teamImage.image == nil) {
        teamImage.image = UIImage(named: "default")
        }*/
        
        // stesso controllo per le immagini nell'history
        
    }*/
    
}
