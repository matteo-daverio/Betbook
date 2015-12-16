//
//  Bet.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 15/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation

class Bet {
	
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

}