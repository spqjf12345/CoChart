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
import Charts

class DataViewController: UIViewController {

    @IBOutlet weak var todayPsChartView: BarChartView!
    
    ///Total View
    @IBOutlet weak var todayPsCount: UILabel!
    @IBOutlet weak var totalPsCount: UILabel!
    @IBOutlet weak var totalDtCount: UILabel!
    
    ///Local View
    @IBOutlet weak var localCircleChartView: PieChartView!
    @IBOutlet weak var tableView: UITableView!

    
    var viewModel = DataViewModel(covidUseCase: CovidUseCase(covidRepository: CovidRepository(networkRequest: DefaultRequestable())))
    
    private var cancellables: Set<AnyCancellable> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.setBarChart(dataPoints: self.viewModel.chartData)
            self.setCircleChart(dataPoints: self.viewModel.localTopFiveRank)
            LoadingIndicator.hideLoading()
        }
        bindUI()
        setUptableview()
        //addChartView()
    }
    
    func setUpUI(){

    }
    
    func setUptableview(){
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(<#T##UINib?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    
    
    func bindUI(){
        self.viewModel.totalCovidPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] entities in
                guard let self = self else { return }
                self.todayPsCount.text = "\(entities?.TotalCaseBefore ?? "")명"
                self.totalPsCount.text = "\(entities?.TotalCase ?? "")명"
                self.totalDtCount.text = "\(entities?.TotalDeath ?? "")명"
            }
            .store(in: &self.cancellables)
        
    }
    
    
    func setBarChart(dataPoints: [(String, Int)]){
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataPoints[i].1))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.colors = [.darkGray]
        let chartData = BarChartData(dataSet: chartDataSet)
        todayPsChartView.data = chartData
        //chartDataSet.highlightEnabled = false
        todayPsChartView.doubleTapToZoomEnabled = false
        todayPsChartView.xAxis.labelPosition = .bottom
        todayPsChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints.map{ $0.0 })
        todayPsChartView.rightAxis.enabled = false
        //chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        todayPsChartView.drawGridBackgroundEnabled = false
        todayPsChartView.xAxis.drawGridLinesEnabled = false
        todayPsChartView.setVisibleXRangeMaximum(20)
        todayPsChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        todayPsChartView.dragXEnabled = true
    }
    
    func setCircleChart(dataPoints: [String: Double]){
        let points: [String] = dataPoints.map { $0.key }
        let values: [Double] = dataPoints.map { $0.value }
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: values[i], label: points[i], data:  points[i] as AnyObject)
          dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        localCircleChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
        return colors
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

extension DataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.viewModel
    }
}

extension DataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}




