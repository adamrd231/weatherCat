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
        Array(repeating: .init(.adaptive(minimum: 2)), count: 2)
    }
    
    var body: some View {
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
                userOptionsButton
                    .padding(.horizontal)
            } 
        }
        .task {
            await vm.setupWeather()
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
       
            LazyVGrid(columns: items, spacing: 10) {
                if let windSpeed = vm.weatherData?.current.windMph {
                    Text("\(windSpeed.description)mph")
                }
                if let location = vm.weatherData?.location.region {
                    Text(location)
                }
            }
        }
//        VStack {
//            Divider()
//            HStack(alignment: .center, spacing: 25) {
//                VStack(alignment: .leading) {
//                    if let tempF = vm.weatherData?.current.tempF {
//                    HStack(alignment: .center, spacing: 10) {
//                        Image(systemName: "thermometer")
//                            .resizable()
//                            .frame(width: 20, height: 25, alignment: .center)
//
//                        Text(tempF.description)
//                            .font(.title)
//                            .fontWeight(.bold)
//                        }
//                    }
//                    if let windSpeed = vm.weatherData?.current.windMph {
//                        Text("\(windSpeed.description)mph")
//                    }
//                    if let location = vm.weatherData?.location.region {
//                        Text(location)
//                    }
//                }
//
//
//                HStack(alignment: .center) {
//                    Image(systemName: "bubble.left")
//                        .resizable()
//                        .frame(width: 25, height: 25, alignment: .center)
//                    Text(vm.purrbo.tempature.rawValue)
//                        .font(.title)
//                        .fontWeight(.bold)
//                }
//            }
//        }
    }
    
    var userOptionsButton: some View {
        HStack {
            Button {
                // Update Purrbo's clothing
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(height: 66)
                    Text("Change Clothes")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
}
