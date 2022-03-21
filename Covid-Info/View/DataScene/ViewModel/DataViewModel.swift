//
//  DataViewModel.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import Combine


class DataViewModel {
    var subscriptions = Set<AnyCancellable>()
    let covidRepository: CovidRepository
    
    let request =  CovidRequest(serviceKey: Config.serviceKey, pageNo: "1", numOfRows: "10", startCreateDt: "20200310", endCreateDt: "20200315")
    
    init(covidRepository: CovidRepository) {
        self.covidRepository = covidRepository
    }
    
    func getCovid() {
        covidRepository.getCovid(request: request)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("opps \(error)")
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue : { response in
                print("res \(response)")
            }.store(in: &subscriptions)
    }
}
