//
//  InfoView.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/23.
//

import SwiftUI

struct InfoView: View {
    var info: SocialDistance!
    
    init() {
        let url = Bundle.main.url(forResource: "SocialDistance", withExtension: "json")!
        
        let data = try! Data(contentsOf: url)
        
        info = try! JSONDecoder().decode(SocialDistance.self, from: data)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 6) {
                Text("가이드라인").font(.system(size: 30, weight: .bold, design: .default))
                Spacer()
                InfoTitleView(startDate: info.dueDate[0], endDate: info.dueDate[1])
                Spacer()
                CenterView(summary: info.summary)
                Spacer()
                CategoryView(category: info.category)
    
            }
        }.padding()
       
    }
}

struct InfoTitleView: View {
    var startDate: String = ""
    var endDate: String = ""
    var body: some View {
        Text("거리두기 방침 \(date(date: Date())) 기준").font(.system(size: 20, weight: .semibold, design: .default))
        Text("* 시행 일자 <\(startDate) ~ \(endDate)>").font(.system(size: 15, weight: .light, design: .default)).foregroundColor(.gray)
    }
    
    func date(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        let str = dateFormatter.string(from: date)
        return str
    }
}

struct CenterView: View {
    var summary: [Summary]
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("* 핵심 (요약)").font(.system(size: 18, weight: .semibold, design: .default)).padding([.top, .leading])
            ForEach(summary, id: \.title) { item in
                   VStack {
                       CenterViewRow(summary: item)
                       Divider()
                   }
               }
        }.background(Color.teal) .cornerRadius(15)
    }
}

struct CategoryView: View {
    var category: [Category]
    let layout = [GridItem(.adaptive(minimum: 80))]
    var body: some View {
        VStack(alignment: .leading, spacing: 2){
            Text("* 카테고리").font(.system(size: 18, weight: .semibold, design: .default)).padding([.top, .leading])
            
            LazyVGrid(columns: layout, spacing: 20) {
                ForEach(category, id: \.id) { items in
                    let buttonStr = items.place.joined(separator: "/ ")
                    CategoruButton(name: buttonStr)
                }
            }
        }.background(Color.green).cornerRadius(15)
        
    }
}

struct CenterViewRow: View {
    var summary: Summary
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(summary.title).font(.system(size: 16, weight: .semibold, design: .default)).padding()
            ForEach(summary.detail, id: \.self) { detail in
                Text(detail).font(.system(size: 14))
            }.padding([.leading, .trailing])
        }
    }
}

struct CategoruButton: View {
    var name: String = ""
    var body: some View {
        Button(action: {
            
        }) {
            Text(name)
                .padding()
                .background(.white)
                .cornerRadius(40)
                .foregroundColor(.purple)
                .font(.system(size: 13))
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple, lineWidth: 5)
                    )
        }
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
