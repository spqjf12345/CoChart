//
//  InfoView.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/23.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var info: SocialDistances
    
    var body: some View {
        ScrollView() {
            VStack {
                
            }
        }
    }
}

struct InfoTitleView: View {
    var body: some View {
        Text("거리두기 방침 ()")
    }
    
    
}

final class SocialDistances: EnvironmentObject {
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
