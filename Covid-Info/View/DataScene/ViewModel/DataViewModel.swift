//
//  DataViewModel.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import Combine
import Foundation


class DataViewModel: ObservableObject {
    
    enum LocalAreaType: String, CaseIterable {
        case seoul = "서울"
        case busan = "부산"
        case daegu = "대구"
        case incheon = "인천"
        case gwangju = "광주"
        case daejeon = "대전"
        case ulsan = "울산"
        case sejong = "세종"
        case gyeonggi = "경기"
        case gangwon = "강원"
        case chungbuk = "충북"
        case chungnam = "충남"
        case jeonbuk = "전북"
        case jeonnam = "전남"
        case gyeongbuk = "경북"
        case gyeongnam = "경남"
        case jeju = "제주"
    }
    
    struct LocalAreaCell {
        var opened = Bool()
        var data: [String: Any]
    }
    
    var cancellables = Set<AnyCancellable>()
    let covidUseCase: CovidUseCase
    
    var totalCovidPublisher: AnyPublisher<TotalCovid?, Never> { self.$totalCovid.eraseToAnyPublisher() }
    var localRankingPublisher: AnyPublisher<[String: Double], Never> { self.$localTopFiveRank.eraseToAnyPublisher() }
        
    @Published var chartData: [(String, Int)] = []
    @Published var localTopFiveRank: [String : Double] = [:]
    @Published var covidData: CovidResponse?
    @Published var totalCovid: TotalCovid? = nil
    @Published var localCovid: LocalCovid? = nil
    
    var localArea: [LocalAreaCell] = []
    var localCovidCount = 17
    
    init(covidUseCase: CovidUseCase) {
        self.covidUseCase = covidUseCase
        self.getCovid()
        self.getTotalData()
        self.getLocalCovid()
       //self.localAreaCell()
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
        let request =  CovidRequest(serviceKey: Config.baseServiceKey, pageNo: "1", numOfRows: "1", startCreateDt: "20201210", endCreateDt: "20201230")
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
    }
    
    func getTotalData() {
        covidUseCase.getTotalCovid()
            .sink  { (completion) in
                switch completion {
                case .failure(let error):
                    print("opps \(error)")
                case .finished:
                    self.getFiveRank()
                }
            } receiveValue : { response in
                self.totalCovid = response
            }.store(in: &cancellables)
    }
    
    func getFiveRank() {
        if let totalCovid = totalCovid {
            self.localTopFiveRank = [totalCovid.city1n : Double(totalCovid.city1p)!, totalCovid.city2n : Double(totalCovid.city2p)!, totalCovid.city3n : Double(totalCovid.city3p)!, totalCovid.city4n : Double(totalCovid.city4p)!, totalCovid.city5n : Double(totalCovid.city5p)!]
        }
        
    }
    
    func getLocalCovid(){
        covidUseCase.getLocalCovid()
            .sink  { (completion) in
                switch completion {
                case .failure(let error):
                    print("opps \(error)")
                case .finished:
                    self.localAreaCell()
                }
            } receiveValue : { response in
                print("res \(response)")
                self.localCovid = response
            }.store(in: &cancellables)
    }
    
    func localAreaCell() {
        for i in LocalAreaType.allCases {
            if(localCovid.dictionary.keys.contains("\(i)")){
                let area = localCovid.dictionary.filter { $0.key == "\(i)"}
                localArea.append(LocalAreaCell(opened: false, data: area))
            }
        }
    }
}
