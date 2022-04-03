//
//  UIView.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/03/30.
//

import SwiftUI

extension View {
    func popupNavigationView<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        return self
            .overlay {
                if show.wrappedValue {
                    // MARKL: Geometry reader for reading
                    GeometryReader { proxcy in
                        Color.primary.opacity(0.15)
                            .ignoresSafeArea()
                        
                        let size = proxcy.size
                        NavigationView {
                            content().navigationBarHidden(true)
                        }.frame(width: size.width - 40, height: size.height / 2, alignment: .center)
                            .cornerRadius(15)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            
                            
                    }
                }
            }
    }
    
    
}

extension View {
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}
