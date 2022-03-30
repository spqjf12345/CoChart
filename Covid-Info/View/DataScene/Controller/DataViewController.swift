//
//  DataViewController.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import UIKit
import Combine
import SwiftUI
import SnapKit
import MapKit
import Charts

class DataViewController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!
    var indicatorView = UIActivityIndicatorView()
    
    var viewModel = DataViewModel(covidUseCase: CovidUseCase(covidRepository: CovidRepository(networkRequest: DefaultRequestable())))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getCovid()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(self.indicatorView)
        LoadingIndicator.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.setChart(dataPoints: self.viewModel.chartData)
            LoadingIndicator.hideLoading()
        }
        //addChartView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setUpUI(){

    }
    
    
    func setChart(dataPoints: [(String, Int)]){
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataPoints[i].1))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.colors = [.darkGray]
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        //chartDataSet.highlightEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints.map{ $0.0 })
        chartView.rightAxis.enabled = false
        //chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.setVisibleXRangeMaximum(20)
        chartView.xAxis.setLabelCount(dataPoints.count, force: false)
        chartView.dragXEnabled = true
    }
    
//    func addChartView(){
//        let barChartView = ChartView(chartData: viewModel)
//        let controller = UIHostingController(rootView: barChartView)
//        self.addChild(controller)
//        controller.view.translatesAutoresizingMaskIntoConstraints = false
//        chartView.addSubview(controller.view)
//
//        controller.didMove(toParent: self)
//        controller.view.snp.makeConstraints { make in
//            make.top.equalTo(chartView.snp.top).offset(100)
//            make.leading.equalTo(chartView.snp.leading)
//            make.trailing.equalTo(chartView.snp.trailing)
//            make.bottom.equalTo(chartView.snp.bottom).offset(-100)
//        }
//    }
    
   

}




