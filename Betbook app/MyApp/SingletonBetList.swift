//
//  SingletonBetList.swift
//  MyApp
//
//  Created by Alessandro Cimbelli on 16/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation

//This is the main class to applay a singleton pattern with a lazy initialization
class SingletonBetList{
	
	//Property
	private var sharedInstance: [Bet]?
	
	//Methods
	func getInstance()-> [Bet]{
		if(sharedInstance == nil){
			self.sharedInstance = [Bet]()
		}
		
		return self.sharedInstance!
	}
	
}