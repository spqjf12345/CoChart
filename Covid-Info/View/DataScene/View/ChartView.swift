//
//  ChartView.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/22.
//

import SwiftUI
import SwiftUICharts
import Charts

struct ChartView: View {
    @ObservedObject var chartData:  DataViewModel
    
    var body: some View {
        BarChartView(data: ChartData(values: chartData.chartData), title: "",dropShadow = false, style: Styles.barChartMidnightGreenLight, form: CGSize(width:800, height:200))
            
            
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chartData: DataViewModel(covidUseCase: CovidUseCase(covidRepository: CovidRepository(networkRequest: DefaultRequestable()))))
    }
}
