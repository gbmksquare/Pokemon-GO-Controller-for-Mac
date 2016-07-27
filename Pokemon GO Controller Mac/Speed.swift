//
//  Speed.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 27..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa

enum Speed: Int {
    case Walk, Run, Cycle, Drive, Race
    
    var value: Double {
        // meter per second
        switch self {
        case .Walk: return 1.5
        case .Run: return 5
        case .Cycle: return 9
        case .Drive: return 22
        case .Race: return 35
        }
    }
    
    var jitter: Double {
        switch self {
        case .Walk: return 0
        case .Run: return 0
        case .Cycle: return 0
        case .Drive: return 1
        case .Race: return 1.5
        }
    }
    
    init?(value: Double) {
        switch value {
        case 1.5: self = .Walk
        case 5: self = .Run
        case 9: self = .Cycle
        case 22: self = .Drive
        case 35: self = .Race
        default: return nil
        }
    }
}
