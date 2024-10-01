//
//  WFCFavoriteDetailView.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 01/10/24.
//

import SwiftUI

struct WFCFavoriteDetailView: View {
    @ObservedObject var weatherViewModel: WFCWeatherViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        WFCCityView(weatherViewModel: weatherViewModel)
                            .padding(.top, 10)
                    }
                }.padding(.top, 45)
            }.background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
}
