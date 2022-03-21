//
//  DataViewController.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import UIKit
import Charts
import Combine

class DataViewController: UIViewController {

    @IBOutlet var chartView: BarChartView!
    let viewModel = DataViewModel(covidRepository: CovidRepository(networkRequest: DefaultRequestable()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCovid()
    }
        
//        let request =  CovidRequest(serviceKey: Config.serviceKey, pageNo: "1", numOfRows: "10", startCreateDt: "20200310", endCreateDt: "20200315")
//        let url = URL(string: "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=oipI8NxGLgvlVJ%2FRKV%2BDV8%2FJnDK%2B13nk5DPurbD3RpTJ%2BFI796bZSifKtF3%2F626Im4LJQppuOfL%2F7WSwCMmvzg%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20200310&endCreateDt=20200315")!
//        let urlRequest = URLRequest(url: url)
//        print(urlRequest)
//        URLSession.shared.dataTask(with: urlRequest) {
//            (data, response, error) -> Void in
//            do {
//                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
//                    // Http 통신이 실패한 경우
//                    return
//                }
//                guard let returnStr = String(data: data!, encoding: .utf8) else {
//                    return
//                }
//
//                 let xmlStr = returnStr
//                 let parser = ParseXMLData(xml: xmlStr)
//                 let jsonStr = parser.parseXML()
//                 print("json \(jsonStr)")
//                 print(returnStr)
//
//                 let data: Data? = jsonStr.data(using: .utf8)
////                 let json = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
////                  print(json ?? "Empty Data")
//                 let d = try JSONDecoder().decode(CovidResponse.self, from: data!)
//                 print(d)
//
//            } catch let DecodingError.dataCorrupted(context) {
//                print(context)
//            } catch let DecodingError.keyNotFound(key, context) {
//                print("Key '\(key)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.valueNotFound(value, context) {
//                print("Value '\(value)' not found:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch let DecodingError.typeMismatch(type, context)  {
//                print("Type '\(type)' mismatch:", context.debugDescription)
//                print("codingPath:", context.codingPath)
//            } catch {
//                print("error: ", error)
//            }
//        }.resume()
//    }
}
