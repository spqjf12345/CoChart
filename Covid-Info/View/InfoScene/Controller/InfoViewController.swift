//
//  InfoViewController.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/21.
//

import UIKit
import SnapKit
import SwiftUI

class InfoViewController: UIViewController {
    @IBOutlet weak var frameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
  
    }
    
    func addSubview(){
        let infoView = InfoView()
        let controller = UIHostingController(rootView: infoView)
        self.addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        frameView.addSubview(controller.view)
        
        controller.didMove(toParent: self)
        controller.view.snp.makeConstraints { make in
            make.top.equalTo(frameView.snp.top)
            make.leading.equalTo(frameView.snp.leading)
            make.trailing.equalTo(frameView.snp.trailing)
            make.bottom.equalTo(frameView.snp.bottom)
        }
    }
    

}
