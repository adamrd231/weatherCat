//
//  ContentView.swift
//  weather
//
//  Created by Adam Reed on 5/9/22.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @EnvironmentObject var vm: HomeViewModel
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 20)), count: 2)
    }
    
    var body: some View {
        TabView {
            // MARK: Home View - Current Purrbo State and Weather 
            ZStack {
                VStack(alignment: .trailing) {
                    nightOrDayModule
                    Spacer()
                }
                
                VStack {
                    Image(vm.purrbo.isWearingPants == false ? "purrbo-shorts" : "purrbo-pants")
                        .resizable()
                        .frame(width: 150, height: 200, alignment: .center)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
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
                ForEach(vm.weatherDashboard) { item in
                    WeatherDashboardItem(weatherItem: item)
                }
            }
            .padding()
        }
    }
    
    
}
