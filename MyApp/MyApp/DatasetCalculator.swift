//
//  DatasetCalculator.swift
//  MyApp
//
//  Created by Matteo on 20/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

public class DatasetCalculator {
    
    private let bettingAmount: Double      // P
    private let potentialWinning: Double   // V
    private let brandMultiplier: Double    // Q
    
    private var maxWin: Double?            // (V - P)
    private var maxCovering: Double?       // (V - P) * Q
    private var intersection: (Double, Double)?
    
    public init(bettingAmount: Double, potentialWinning: Double, brandMultiplier: Double) {
        self.bettingAmount = bettingAmount
        self.potentialWinning = potentialWinning
        self.brandMultiplier = brandMultiplier
        self.calculateValues()
    }
    
    public func returnMaxDataset() -> [(Double,Double)] {
        return [(0, maxWin!),intersection!,(maxWin!, maxCovering!)]
    }
    
    public func returnMinDataset() -> [(Double,Double)] {
        return [(0, 0),intersection!,(maxWin!, 0)]
    }
    
    private func calculateValues() {
        
        maxWin = potentialWinning - bettingAmount   // V - P
        maxCovering = maxWin! * brandMultiplier    // (V - P) * Q
        
        // y1 = -x + (v - p) , y2 = q * x
        
        let xIntersect = -((maxWin!) / (-1 - brandMultiplier))
        intersection = (xIntersect, (-xIntersect + maxWin!))
        
    }
    
}
