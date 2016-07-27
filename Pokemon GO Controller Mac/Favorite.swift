//
//  Favorite.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 26..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa
import MapKit

class Favorite: NSObject, NSCoding {
    var coordinate: CLLocationCoordinate2D
    var name: String?
    
    init(coordinate: CLLocationCoordinate2D, name: String? = nil) {
        self.coordinate = coordinate
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        let coordinateData = aDecoder.decodeObjectForKey("coordinate") as! NSData
        self.coordinate = (NSUnarchiver.unarchiveObjectWithData(coordinateData) as! NSValue).MKCoordinateValue
        self.name = aDecoder.decodeObjectForKey("name") as? String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        let coordinateValue = NSValue(MKCoordinate: coordinate)
        let coordinateData = NSArchiver.archivedDataWithRootObject(coordinateValue)
        aCoder.encodeObject(coordinateData, forKey: "coordinate")
        aCoder.encodeObject(name, forKey: "name")
    }
}

func ==(lhs: Favorite, rhs: Favorite) -> Bool {
    return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.name == rhs.name
}
