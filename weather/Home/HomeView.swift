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
    
    var body: some View {
        ZStack {
            VStack {
                if let daytime = vm.weatherData?.current.isDay {
                    if daytime == 1 {
                        Image("sun")
                            .resizable()
                            .frame(width: 150, height: 150, alignment: .center)
                            .offset(x: 100, y: -300)
                            .background(Color.white)
                    }
                }
                
                Image(vm.purrbo.isWearingPants == false ? "purrbo-shorts" : "purrbo-pants")
                    .resizable()
                    .frame(width: 150, height: 200, alignment: .center)
            }
            
            VStack {
                // Sun
      
                Spacer()
                userDashboard
                userOptionsButtons
            }
            
            
            .padding(.horizontal)
        }
        .task {
            await vm.setupWeather()
        }
        .onReceive(timer, perform: { _ in
            
            for index in 0..<vm.clouds.count {
                if vm.clouds[index].xPosition > 350 {
                    vm.clouds[index].xPosition = -350
                } else {
                    vm.clouds[index].xPosition += CGFloat(Double.random(in: 5...50))
                }
            }
        })

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeViewModel)
    }
}

extension HomeView {
    var userDashboard: some View {
        VStack {
            Divider()
            HStack(alignment: .center, spacing: 25) {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "thermometer")
                        .resizable()
                        .frame(width: 20, height: 25, alignment: .center)
                    if let tempF = vm.weatherData?.current.tempF {
                        Text(tempF.description)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                
                HStack(alignment: .center) {
                    Image(systemName: "bubble.left")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                    Text(vm.purrbo.tempature.rawValue)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    var userOptionsButtons: some View {
        HStack {
            Button(action: {
                vm.purrbo.isWearingPants = true
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(height: 66)
                    Text("Pants")
                        .foregroundColor(.white)
                }
                
            }
            Button(action: {
                vm.purrbo.isWearingPants = false

            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(height: 66)
                    Text("Shorts")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    
    
    var showClouds: some View {
        VStack {
            ForEach(vm.clouds, id: \.id) { cloud in
                Image("cloud-background")
                    .resizable()
                    .frame(width: 150, height: 75)
                    .offset(x: cloud.xPosition, y: cloud.yPosition)
            }
            Spacer()
        }
    }
}
