//
//  weatherApp.swift
//  weather
//
//  Created by Adam Reed on 5/9/22.
//

import SwiftUI

@main
struct weatherApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
