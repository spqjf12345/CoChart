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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
