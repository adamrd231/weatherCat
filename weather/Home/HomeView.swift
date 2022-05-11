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
            
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .frame(height: 66)
                        Text("Pants")
                            .foregroundColor(.white)
                    }
                    
                }
                Button(action: {
                    
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
    }
}
