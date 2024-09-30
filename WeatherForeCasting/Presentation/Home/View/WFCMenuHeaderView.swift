//
//  WFCMenuHeaderView.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI

struct WFCMenuHeaderView: View {
    
    @ObservedObject var weatherViewModel: WFCWeatherViewModel
    
    @State private var searchTerm = "Dubai"
    
    var body: some View {
        HStack {
            TextField("", text: $searchTerm)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
            
            Button {
                weatherViewModel.city = searchTerm
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                    
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack(alignment: .leading) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.5))
        })
    }
}

struct MenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        WFCMenuHeaderView(weatherViewModel: WFCWeatherViewModel())
    }
}
