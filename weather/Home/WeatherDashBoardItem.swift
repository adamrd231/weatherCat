//
//  WeatherDashBoardItem.swift
//  weather
//
//  Created by Adam Reed on 7/31/22.
//

import SwiftUI

struct WeatherItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    
}

struct WeatherDashboardItem: View {
    
    let weatherItem: WeatherItem
    
    var body: some View {
        VStack {
            Text("\(weatherItem.title)")
                .bold()
                .font(.caption)
            Text("\(weatherItem.description)")
                .font(.title3)
                .fontWeight(.light)
               
        }
        .padding()
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(Color.customColors.lightBlue)
        .cornerRadius(.greatestFiniteMagnitude)
        
            
        
    }
}

struct WeatherDashBoardItem_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDashboardItem(weatherItem: WeatherItem(title: "Test", description: "Description"))
    }
}
