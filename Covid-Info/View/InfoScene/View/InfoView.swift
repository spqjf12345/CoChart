//
//  InfoView.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/23.
//

import SwiftUI

struct InfoView: View {
    var info: SocialDistance!
    @State var shown: Bool = false
    @State var category: Category = Category(id: 0, place: [], operatingTime: "", isEat: "", other: "")
    
    init() {
        let url = Bundle.main.url(forResource: "SocialDistance", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        info = try! JSONDecoder().decode(SocialDistance.self, from: data)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("가이드라인").font(.system(size: 30, weight: .bold, design: .default))
                    Spacer()
                    InfoTitleView(startDate: info.dueDate[0], endDate: info.dueDate[1])
                    Spacer()
                    CenterView(summary: info.summary)
                    Spacer()
                    CategoryView(shown: $shown, oneCategory: $category, category: info.category)
        
                }
            }.padding().navigationBarTitle("CoChart", displayMode: .large)
                .navigationBarColor(UIColor(Color("Main-navy")))
        
        }.popupNavigationView(show: $shown, content: {
            DetailCategoryView(category: $category, shown: $shown)
        })
      
    }
    
}

struct InfoTitleView: View {
    var startDate: String = ""
    var endDate: String = ""
    var body: some View {
        Text("거리두기 방침 \(date(date: Date())) 기준").font(.system(size: 20, weight: .semibold, design: .default))
        Text("* 시행 일자 <\(startDate) ~ \(endDate)>").font(.system(size: 15, weight: .light, design: .default)).foregroundColor(Color("Main-navy"))
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
        }.background(Color("100"))
        .cornerRadius(15)
    }
}

struct CategoryView: View {
    @Binding var shown: Bool
    @Binding var oneCategory: Category
    
    var category: [Category]
    //var layout = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    var layout = [GridItem(.adaptive(minimum: 100))]
    var body: some View {
        VStack(alignment: .leading, spacing: 2){
            Text("* 카테고리").font(.system(size: 18, weight: .semibold, design: .default)).padding([.top, .leading])
            
            LazyVGrid(columns: layout, spacing: 2) {
                ForEach(category, id: \.id) { items in
                    let buttonStr = items.place.joined(separator: "/ ")
                    CategoruButton(shown: $shown, category: $oneCategory, total: category, name: buttonStr, tag: items.id)
                }
            }
        }.background(Color("100"))
        .cornerRadius(15)
        
    }
}

struct CenterViewRow: View {
    var summary: Summary
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(summary.title).font(.system(size: 16, weight: .semibold, design: .default))
                .background(Color("System Yellow 2"))
                .padding()
            ForEach(summary.detail, id: \.self) { detail in
                Text(detail).font(.system(size: 14))
            }.padding([.leading, .trailing])
        }
    }
}

struct CategoruButton: View {
    @Binding var shown: Bool
    @Binding var category: Category
    var total: [Category]
    var name: String!
    var tag: Int
    var body: some View {
        Button(action: {
            withAnimation(.spring()){
                print()
                category = total[tag-1]
                self.shown.toggle()
            }
        }) {
            Text(name)
                .frame(minWidth: 80, maxWidth: .infinity, minHeight: 80)
                .background(Color("200"))
                .cornerRadius(8)
                .foregroundColor(Color("Main-navy"))
                .padding()
                .font(.system(size: 14, weight: .semibold, design: .default))
        }
    }
}

struct DetailCategoryView: View {
    @Binding var category: Category
    @Binding var shown: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack() {
                let places: String = category.place.joined(separator: "/ ")
                Text(places).font(.system(size: 25, weight: .bold, design: .default)).fixedSize(horizontal: false, vertical: true)
                Spacer()
                Button(action: {
                    shown.toggle()
                }){ Image(systemName: "xmark.app").foregroundColor(Color("Main-navy")) }
            }
            Spacer()
            Text("시간 제한").font(.system(size: 25, weight: .bold, design: .default))
            Text("- \(category.operatingTime)").font(.system(size: 15)).fixedSize(horizontal: false, vertical: true)
            Spacer()
            Text("취식 가능").font(.system(size: 25, weight: .bold, design: .default))
            Text("- \(category.isEat)").font(.system(size: 15)).fixedSize(horizontal: false, vertical: true)
            Spacer()
            Text("기타 사항").font(.system(size: 25, weight: .bold, design: .default))
            Text("- \(category.other)").font(.system(size: 15)).fixedSize(horizontal: false, vertical: true)
            
       }.padding()
        .background(Color("System Yellow 3"))
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
