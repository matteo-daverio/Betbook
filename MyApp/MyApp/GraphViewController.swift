//
//  GraphViewController.swift
//  MyApp
//
//  Created by Matteo on 20/12/15.
//  Copyright © 2015 CimboMatte. All rights reserved.
//

import UIKit


class GraphViewController: UIViewController {
    
    private var chart: Chart?
    
    // Diventeranno dei let in teoria, togliendo l'opzionale, DA VEDERE
    private var bettingAmount: Double?
    private var potentialWinning: Double?
    private var brandMultiplier: Double?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // sarà da rimuovere   (0, 20),(15, 5),(20, 6.67)
        bettingAmount = 50.0
        potentialWinning = 200.0
        brandMultiplier = 3.0
        
        // nel caso TOGLIERE GLI OPZIONALI
        let datasetCalculator = DatasetCalculator(bettingAmount: bettingAmount!, potentialWinning: potentialWinning!, brandMultiplier: brandMultiplier!)
        
        let labelSettings = ChartLabelSettings(font: GraphSettings.labelFont)
        
        let chartPointsMax = datasetCalculator.returnMaxDataset().map{ChartPoint(x: ChartAxisValueDouble($0.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
        let chartPointsMin = datasetCalculator.returnMinDataset().map{ChartPoint(x: ChartAxisValueDouble($0.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
        
        
        let xValues = chartPointsMax.map{$0.x}
        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPointsMax, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Betting Amount", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Earning Amount", settings: labelSettings.defaultVertical()))
        
        let chartFrame = GraphSettings.chartFrame(self.view.bounds)
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: GraphSettings.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        
        // Creazione modello del grafico (Line model)
        let lineModel1 = ChartLineModel(chartPoints: chartPointsMax, lineColor: UIColor.redColor(), animDuration: 1, animDelay: 0)
        let lineModel2 = ChartLineModel(chartPoints: chartPointsMin, lineColor: UIColor.blueColor(), animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel1, lineModel2])
        
        // Creazione del tracker
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSize: Env.iPad ? 30 : 20, thumbCornerRadius: Env.iPad ? 16 : 10, thumbBorderWidth: Env.iPad ? 4 : 2, thumbBorderColor: UIColor.blackColor(), infoViewFont: GraphSettings.fontWithSize(Env.iPad ? 26 : 16), infoViewSize: CGSizeMake(Env.iPad ? 400 : 160, Env.iPad ? 70 : 40), infoViewCornerRadius: Env.iPad ? 30 : 15)
        let chartPointsTrackerLayer = CustomLineTrackerLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPointsMin: chartPointsMin, chartPointsMax: chartPointsMax, lineColor: UIColor.blackColor(), animDuration: 1, animDelay: 2, settings: trackerLayerSettings)
        
        // Creazione griglia
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: GraphSettings.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                chartPointsLineLayer,
                chartPointsTrackerLayer
            ]
        )
        
        self.view.addSubview(chart.view)
        self.chart = chart
        
    }
    
}










