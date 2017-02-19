//
//  Speed.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 27..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa

enum Speed: Int {
    case walk, run, cycle, drive, race
    
    var value: Double {
        // meter per second
        // Egg-hatch-safe speed is about 10.5 km/h
        switch self {
        case .walk: return 3
        case .run: return 10
        case .cycle: return 15
        case .drive: return 22
        case .race: return 35
        }
    }
    
    var jitter: Double {
        switch self {
        case .walk: return 0
        case .run: return 0
        case .cycle: return 0
        case .drive: return 1
        case .race: return 1.5
        }
    }
    
    init?(value: Double) {
        switch value {
        case 1.5: self = .walk
        case 5: self = .run
        case 9: self = .cycle
        case 22: self = .drive
        case 35: self = .race
        default: return nil
        }
    }
}
