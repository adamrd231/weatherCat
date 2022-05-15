//
//  PurrboModel.swift
//  weather
//
//  Created by Adam Reed on 5/14/22.
//

import Foundation

struct PurrboModel: Codable {
    var tempPurrboWearsPants: Int
    var isWearingPants: Bool
    var tempature: CurrentTempature
}

enum CurrentTempature: String, Codable {
    case cold, good, warm
}
