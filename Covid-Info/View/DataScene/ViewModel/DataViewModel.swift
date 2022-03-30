//
//  DataViewModel.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import Combine
import Foundation


class DataViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    let covidUseCase: CovidUseCase
    @Published var chartData: [(String, Int)] = []
    
    @Published var covidData: CovidResponse?
    
    init(covidUseCase: CovidUseCase) {
        self.covidUseCase = covidUseCase
    }
    
    func date() -> [String] {
        print("dateFunction")
        print(Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let today = dateFormatter.string(from: Date())
        let firstDay = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -30, to: Date())!)
        print("\(today) \(firstDay)")
        return [today, firstDay]
    }
    
    func chartDate(dt: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd" // 20200315
        let convertDate = dateFormatter.date(from: dt)
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd" //03.15 -> 15
        convertDateFormatter.locale = Locale(identifier:"ko_KR")
        let convertString = convertDateFormatter.string(from: convertDate!)
        return convertString
    }
    
    func getCovid() {
        let request =  CovidRequest(serviceKey: Config.baseServiceKey, pageNo: "1", numOfRows: "10", startCreateDt: "20220110", endCreateDt: "20220210")
        covidUseCase.getCovid(request: request)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("opps \(error)")
                case .finished:
                    self.getChartData()
                }
            } receiveValue : { response in
                //print("res \(response)")
                self.covidData = response
            }.store(in: &cancellables)
    }
    
    func getChartData() {
        let items = covidData.map { $0.response.body.items.item }!
        for i in items {
            let dateString = chartDate(dt: i.stateDt)
            let cnt = Int(i.deathCnt)!
            chartData.append((dateString, cnt))
        }
        chartData = chartData.reversed()
        print(chartData)
    }
}
