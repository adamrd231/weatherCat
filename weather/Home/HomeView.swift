//
//  ContentView.swift
//  weather
//
//  Created by Adam Reed on 5/9/22.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    @State var purrboPictureArray = ["p1-1", "p2"]
    @State var selectedIndex = 0
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView {
            // MARK: Home View - Current Purrbo State and Weather 
            ZStack {
                VStack(alignment: .trailing) {
                    nightOrDayModule
                    Spacer()
                }
                
                VStack {
                    Image(purrboPictureArray[selectedIndex])
                        .resizable()
                        .offset(y: UIScreen.main.bounds.height * 0.05)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                }
                .onReceive(timer) { input in
                    if selectedIndex < 1 {
                        selectedIndex += 1
                    } else {
                        selectedIndex = 0
                    }
                }
                
                VStack {
                    Spacer()
                    userDashboard
                }
            }
            .tabItem {
                tabItemOne
            }
            
            // MARK: Options View - Change Purrbo's outfit
            VStack {
                Text("Options")
            }
            .tabItem {
                tabItemTwo
            }
        }
    }
}



extension HomeView {
    var tabItemOne: some View {
        Label("Purrbo", systemImage: "square.and.pencil")
    }
    
    var tabItemTwo: some View {
        Label("Options", systemImage: "list.dash")
    }
    
    
    @ViewBuilder
    var nightOrDayModule: some View {
        if let daytime = vm.weatherData?.current.isDay {
            if daytime == 1 {
                Image("sun")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .background(Color.white)
                    .offset(x: UIScreen.main.bounds.width * 0.25)
            } else {
                Image("moon")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .background(Color.white)
                    .offset(x: UIScreen.main.bounds.width * 0.25)
            }
        }
    }
    
    
    var userDashboard: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if vm.weatherDashboard.isEmpty {
                    // Show Placeholder for loading dashboard heres
                    ForEach(0..<3) { _ in
                        RoundedRectangle(cornerRadius: .greatestFiniteMagnitude)
                            .foregroundColor(Color(.lightGray))
                            .frame(width: 150, height: 66)
                            .opacity(0.5)
                    }
                    
                    
                        
                } else {
                    ForEach(vm.weatherDashboard) { item in
                        WeatherDashboardItem(weatherItem: item)
                    }
                }
            }
            .padding()
        }
    }
    
    
}


// MARK: Preview Provider
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
