//
//  UnitConverter.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 27..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa

class UnitConverter {
    private static let earthRadius = 6378000.0 // meter
    
    class func latitudeDegrees(fromMeter meter: Double) -> Double {
        return meter / earthRadius * (180 / M_PI)
    }
    
    class func longitudeDegress(fromMeter meter: Double, latitude: Double) -> Double {
        return meter / earthRadius * (180 / M_PI) / cos(latitude * M_PI / 180)
    }
}
