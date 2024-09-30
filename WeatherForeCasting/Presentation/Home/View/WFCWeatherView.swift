//
//  WFCWeatherListView.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI

struct WFCWeatherView: View {
    @ObservedObject var weatherViewModel = WFCWeatherViewModel()
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                WFCMenuHeaderView(weatherViewModel: weatherViewModel)
                    .padding(.horizontal, 10)
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


