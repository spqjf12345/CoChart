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

class DataViewController: UIViewController {

    @IBOutlet weak var chartView: UIView!
    
    var viewModel = DataViewModel(covidUseCase: CovidUseCase(covidRepository: CovidRepository(networkRequest: DefaultRequestable())))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCovid()
        addChartView()
    }
    
    func addChartView(){
        let barChartView = ChartView(chartData: viewModel)
        let controller = UIHostingController(rootView: barChartView)
        self.addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        chartView.addSubview(controller.view)
        
        controller.didMove(toParent: self)
        controller.view.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.top).offset(100)
            make.leading.equalTo(chartView.snp.leading)
            make.trailing.equalTo(chartView.snp.trailing)
            make.bottom.equalTo(chartView.snp.bottom).offset(-100)
        }
    }
}
