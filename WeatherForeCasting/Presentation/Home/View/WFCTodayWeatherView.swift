//
//  WFCWeatherListView.swift
//  WFCTodayWeatherView
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI

struct WFCTodayWeatherView: View {
    @ObservedObject var weatherViewModel: WFCWeatherViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20) {            
                VStack(alignment: .leading) {
                    Text("\(weatherViewModel.temperature)℃")
                        .font(.system(size: 42))
                    Text(weatherViewModel.conditions)
                }
            }
            HStack {
                Spacer()
                widgetView(image: "wind", color: .green, title: "\(weatherViewModel.windSpeed) km/hr")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(weatherViewModel.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .red, title: "\(weatherViewModel.rainChances)")
                Spacer()
                if weatherViewModel.showFavoriteIcon {
                    NavigationLink {
                        WFCFavoritesView(weatherViewModel: weatherViewModel)
                    } label: {
                        widgetView(image: "heart", color: .red, title: "Favorite")
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]),
                        startPoint: .top,
                        endPoint: .bottom))
                .opacity(0.3)
        )
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
    
    private func widgetView(image: String, color: Color, title: String) -> some View {
        VStack {
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(color)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            Text(title)
        }
    }
}

struct TodayWeather_Previews: PreviewProvider {
    static var previews: some View {
        WFCTodayWeatherView(weatherViewModel: WFCWeatherViewModel())
    }
}
