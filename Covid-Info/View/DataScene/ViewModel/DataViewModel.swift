//
//  DataViewModel.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import Combine


class DataViewModel {
    var cancellables = Set<AnyCancellable>()
    let covidUseCase: CovidUseCaseProtocol
    @Published var covidData: CovidResponse?
    
    let request =  CovidRequest(serviceKey: Config.serviceKey, pageNo: "1", numOfRows: "10", startCreateDt: "20200310", endCreateDt: "20200315")
    
    init(covidUseCase: CovidUseCaseProtocol) {
        self.covidUseCase = covidUseCase
    }
    
    func getCovid(for request: CovidRequest) {
        covidUseCase.getCovidData(for: request)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("opps \(error)")
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue : { response in
                print("res \(response)")
            }.store(in: &cancellables)
    }
}
