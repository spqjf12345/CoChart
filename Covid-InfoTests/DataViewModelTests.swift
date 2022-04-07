//
//  DataViewModelTests.swift
//  Covid-InfoTests
//
//  Created by JoSoJeong on 2022/04/07.
//

import XCTest
import Combine
@testable import Covid_Info

class DataViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var viewModel: DataViewModel!
    private var useCase: CovidUseCase!
    private var repository: DummyCovidRepository!
    
    override func setUp() {
        repository = DummyCovidRepository(isSuccessMode: true)
        useCase = CovidUseCase(covidRepository: repository)
        viewModel = DataViewModel(covidUseCase: useCase)
    }

    override func tearDown() {
        self.cancellables = []
    }

    func GetCovidUsecaseTest() {
        let request = repository.request
        let expectation = expectation(description: #function)
        var errorResult: NetworkError?
        
        useCase.getCovid(request: request)
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                errorResult = error
                expectation.fulfill()
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNil(errorResult)
    }
    
    func getTotalCovidText() {
        
        let expectation = expectation(description: #function)
        var errorResult: NetworkError?
        
        useCase.getTotalCovid()
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                errorResult = error
                expectation.fulfill()
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNil(errorResult)
    }
    
    func getLocalCovidTest() {
        let expectation = expectation(description: #function)
        var errorResult: NetworkError?
        
        useCase.getLocalCovid()
            .sink { completion in
                guard case .failure(let error) = completion else { return }
                errorResult = error
                expectation.fulfill()
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNil(errorResult)
        
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
