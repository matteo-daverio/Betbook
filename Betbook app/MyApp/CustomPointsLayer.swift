//
//  CustomPointsLayer.swift
//  MyApp
//
//  Created by Matteo on 20/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit

public struct CustomLayerModel<T: ChartPoint> {
    public let chartPoint: T
    public let index: Int
    public let screenLoc: CGPoint
    
    init(chartPoint: T, index: Int, screenLoc: CGPoint) {
        self.chartPoint = chartPoint
        self.index = index
        self.screenLoc = screenLoc
    }
}

public class CustomPointsLayer<T: ChartPoint>: ChartCoordsSpaceLayer {
    
    let chartPointsModelsMin: [CustomLayerModel<T>]
    let chartPointsModelsMax: [CustomLayerModel<T>]
    
    private let displayDelay: Float
    
    public var chartPointScreenLocs: [CGPoint] {
        return self.chartPointsModelsMax.map{$0.screenLoc}
    }
    
    public init(xAxis: ChartAxisLayer, yAxis: ChartAxisLayer, innerFrame: CGRect, chartPointsMin: [T], chartPointsMax: [T], displayDelay: Float = 0) {
        self.chartPointsModelsMin = chartPointsMin.enumerate().map {index, chartPoint in
            let screenLoc = CGPointMake(xAxis.screenLocForScalar(chartPoint.x.scalar), yAxis.screenLocForScalar(chartPoint.y.scalar))
            return CustomLayerModel(chartPoint: chartPoint, index: index, screenLoc: screenLoc)
        }
        
        self.chartPointsModelsMax = chartPointsMax.enumerate().map {index, chartPoint in
            let screenLoc = CGPointMake(xAxis.screenLocForScalar(chartPoint.x.scalar), yAxis.screenLocForScalar(chartPoint.y.scalar))
            return CustomLayerModel(chartPoint: chartPoint, index: index, screenLoc: screenLoc)
        }
        
        self.displayDelay = displayDelay
        
        super.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame)
    }
    
    
    override public func chartInitialized(chart chart: Chart) {
        if self.displayDelay == 0 {
            self.display(chart: chart)
        } else {
            dispatch_after(ChartUtils.toDispatchTime(self.displayDelay), dispatch_get_main_queue()) {() -> Void in
                self.display(chart: chart)
            }
        }
    }
    
    func display(chart chart: Chart) {}
    
    public func chartPointScreenLoc(chartPoint: ChartPoint) -> CGPoint {
        return self.modelLocToScreenLoc(x: chartPoint.x.scalar, y: chartPoint.y.scalar)
    }
    
    public func modelLocToScreenLoc(x x: Double, y: Double) -> CGPoint {
        return CGPointMake(
            self.xAxis.screenLocForScalar(x),
            self.yAxis.screenLocForScalar(y))
    }
    
    public func chartPointsForScreenLoc(screenLoc: CGPoint) -> [T] {
        return self.chartPointsWith(filter: {$0 == screenLoc})
    }
    
    public func chartPointsForScreenLocX(x: CGFloat) -> [T] {
        return self.chartPointsWith(filter: {$0.x == x})
    }
    
    public func chartPointsForScreenLocY(y: CGFloat) -> [T] {
        return self.chartPointsWith(filter: {$0.y == y})
        
    }
    
    // smallest screen space between chartpoints on x axis
    public lazy var minXScreenSpace: CGFloat = {
        return self.minAxisScreenSpace{$0.x}
    }()
    
    // smallest screen space between chartpoints on y axis
    public lazy var minYScreenSpace: CGFloat = {
        return self.minAxisScreenSpace{$0.y}
    }()
    
    private func minAxisScreenSpace(dimPicker dimPicker: (CGPoint) -> CGFloat) -> CGFloat {
        return self.chartPointsModelsMax.reduce((CGFloat.max, -CGFloat.max)) {tuple, viewWithChartPoint in
            let minSpace = tuple.0
            let previousScreenLoc = tuple.1
            return (min(minSpace, abs(dimPicker(viewWithChartPoint.screenLoc) - previousScreenLoc)), dimPicker(viewWithChartPoint.screenLoc))
            }.0
    }
    
    private func chartPointsWith(filter filter: (CGPoint) -> Bool) -> [T] {
        return self.chartPointsModelsMax.reduce(Array<T>()) {u, chartPointModel in
            let chartPoint = chartPointModel.chartPoint
            if filter(self.chartPointScreenLoc(chartPoint)) {
                return u + [chartPoint]
            } else {
                return u
            }
        }
    }
}

