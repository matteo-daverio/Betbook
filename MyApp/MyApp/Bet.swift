//
//  Bet.swift
//  MyApp
//
//  Created by Matteo on 11/01/16.
//  Copyright © 2016 CimboMatteo All rights reserved.
//

import Foundation

class Bet: NSObject, NSCoding {
    
    var homeTeam: String?
    var awayTeam: String?
    var date: String?
    var hour: String?
    var league: String?
    var country: String?
    var kindOfBet: String?
    var bet: String?
    var betValue: String?
    var brand: String?
    
    //Methods
    
    init(homeTeam: String, awayTeam: String, date: String, hour: String, league: String, country: String, kindOfBet: String, bet: String, betValue: String, brand: String){
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.date = date
        self.hour = hour
        self.league = league
        self.country = country
        self.kindOfBet = kindOfBet
        self.bet = bet
        self.betValue = betValue
        self.brand = brand
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let homeTeam = aDecoder.decodeObjectForKey("homeTeam") as! String
        let awayTeam = aDecoder.decodeObjectForKey("awayTeam") as! String
        let date = aDecoder.decodeObjectForKey("date") as! String
        let hour = aDecoder.decodeObjectForKey("hour") as! String
        let league = aDecoder.decodeObjectForKey("league") as! String
        let country = aDecoder.decodeObjectForKey("country") as! String
        let kindOfBet = aDecoder.decodeObjectForKey("kindOfBet") as! String
        let bet = aDecoder.decodeObjectForKey("bet") as! String
        let betValue = aDecoder.decodeObjectForKey("betValue") as! String
        let brand = aDecoder.decodeObjectForKey("brand") as! String
        self.init(homeTeam: homeTeam, awayTeam: awayTeam, date: date, hour: hour, league: league, country: country, kindOfBet: kindOfBet, bet: bet, betValue: betValue, brand: brand)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(homeTeam, forKey: "homeTeam")
        aCoder.encodeObject(awayTeam, forKey: "awayTeam")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(hour, forKey: "hour")
        aCoder.encodeObject(league, forKey: "league")
        aCoder.encodeObject(country, forKey: "country")
        aCoder.encodeObject(kindOfBet, forKey: "kindOfBet")
        aCoder.encodeObject(bet, forKey: "bet")
        aCoder.encodeObject(betValue, forKey: "betValue")
        aCoder.encodeObject(brand, forKey: "brand")
    }
    
}