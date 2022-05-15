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
    

    
    var body: some View {

        VStack {
            VStack {
                HStack {
                    if let locationCity = vm.weatherData?.location.name,
                       let locationRegion = vm.weatherData?.location.region {
                        Text("\(locationCity), \(locationRegion)")
                    }
//                    Text(vm.weatherData?.location.name ?? "")
//                    Text(vm.weatherData?.location.region ?? "")
                }
                HStack {
                    Text("Lat")
                        .bold()
                    Text(vm.coordinates?.latitude.description ?? "Lat not available")
                }
                HStack {
                    Text("Long")
                        .bold()
                    Text(vm.coordinates?.longitude.description ?? "Long not Available")
                }
            }
            Spacer()
            // Kitty
            Text(vm.purrbo.isWearingPants == true ? "Purbo is wearing pants" : "Purrbo is wearing shorts")
            Text(vm.purrbo.tempature.rawValue)
            Spacer()
            VStack {
                HStack {
                    Text("Current Tempature")
                    Text(vm.weatherData?.current.tempF?.description ?? "Tempature Not available")
                }
                HStack {
                    Text("Feels Like")
                    Text(vm.weatherData?.current.feelslikeF?.description ?? "Tempature Not available")
                }
            }
            
            HStack {
                Button(action: {
                    vm.purrbo.isWearingPants = true
                    if let temp = vm.weatherData?.current.tempF {
                        if Double(vm.purrbo.tempPurrboWearsPants) > temp {
                            print("purbo is good")
                            vm.purrbo.tempature = .good
                        } else {
                            print("purrbo is hot")
                            vm.purrbo.tempature = .warm
                        }
                    }
                    
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
                    if let temp = vm.weatherData?.current.tempF {
                        if Double(vm.purrbo.tempPurrboWearsPants) < temp {
                           print("Purbo is good")
                            vm.purrbo.tempature = .good
                            
                        } else {
                            print("purrbo is cold")
                            vm.purrbo.tempature = .cold
                        }
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .frame(height: 66)
                        Text("Shorts")
                            .foregroundColor(.white)
                    }
                    
                }
            }.padding()
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeViewModel)
    }
}
