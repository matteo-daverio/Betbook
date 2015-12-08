//
//  SingletonSoccerInformationModel.swift
//  CocoaPods
//
//  Created by Alessandro Cimbelli on 03/11/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import Foundation

//This is the main class to applay a singleton pattern with a lazy initialization
class SingletonSoccerInformationModel{

	//Property
	private var sharedInstance: SoccerInformationModel?
	
	//Methods
	func getInstance()-> SoccerInformationModel{
		if(sharedInstance == nil){
			self.sharedInstance = SoccerInformationModel()
		}
		
		return self.sharedInstance!
		
	}
	
}