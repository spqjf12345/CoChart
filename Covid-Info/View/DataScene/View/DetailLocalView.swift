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
                Label(title: { Text(area.name) }, icon: {
                    Image(systemName: area.icon)
                        .renderingMode(.template)
                        .foregroundColor(.black)
                })
            } else {
                Text(area.name)
            }
        }.onAppear() {
            UITableView.appearance().backgroundColor = UIColor.systemGray5
            UITableViewCell.appearance().backgroundColor = UIColor.systemGray5
        }.accentColor(Color.black)
    }
}

struct DetailLocalView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLocalView()
    }
}
