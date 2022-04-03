//
//  DetailLocalView.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/04/03.
//

import SwiftUI

struct DetailLocalView: View {
    
    @EnvironmentObject var viewModel: DataViewModel
    
    var body: some View {
        
        List(viewModel.detailArea, id: \.id, children: \.items) { area in
            if area.items != nil {
                Label(area.name, systemImage: "quote.bubble")
            }else {
                Text(area.name)
            }
        }.onAppear() {
            UITableView.appearance().backgroundColor = UIColor.systemGray5
            UITableViewCell.appearance().backgroundColor = UIColor.systemGray5
        }
    }
}

struct DetailLocalView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLocalView()
    }
}
