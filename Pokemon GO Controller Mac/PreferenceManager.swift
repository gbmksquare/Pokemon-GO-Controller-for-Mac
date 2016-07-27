//
//  PreferenceManager.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 26..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa
import MapKit

class PreferenceManager {
    static let defaultManager = PreferenceManager()
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var speed: Speed = Speed.Walk {
        didSet {
            defaults.setDouble(speed.value, forKey: "speed")
            defaults.synchronize()
        }
    }
    
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            // Save
            guard let userLocation = userLocation else {
                defaults.removeObjectForKey("userLocation")
                return
            }
            let coordinateValue = NSValue(MKCoordinate: userLocation)
            let coordinateData = NSArchiver.archivedDataWithRootObject(coordinateValue)
            defaults.setObject(coordinateData, forKey: "userLocation")
            defaults.synchronize()
            
            saveUserLocationToGpx()
        }
    }
    
    var favorites: [Favorite]? {
        didSet {
            // Save
            guard let favorites = favorites else {
                defaults.removeObjectForKey("favorites")
                return
            }
            var favoritesData = [NSData]()
            for favorite in favorites {
                let favoriteData = NSKeyedArchiver.archivedDataWithRootObject(favorite)
                favoritesData.append(favoriteData)
            }
            defaults.setObject(favoritesData, forKey: "favorites")
            defaults.synchronize()
        }
    }
    
    // MARK: Initializer
    init() {
        if let speed = Speed(value:defaults.doubleForKey("speed")) {
            self.speed = speed
        }
        if let coordinateData = defaults.objectForKey("userLocation") as? NSData {
            if let coordinateValue = NSUnarchiver.unarchiveObjectWithData(coordinateData) as? NSValue {
                userLocation = coordinateValue.MKCoordinateValue
            }
        }
        if let favoritesData = defaults.arrayForKey("favorites") as? [NSData] {
            var favorites = [Favorite]()
            for favoriteData in favoritesData {
                if let favorite = NSKeyedUnarchiver.unarchiveObjectWithData(favoriteData) as? Favorite {
                    favorites.append(favorite)
                }
            }
            self.favorites = favorites
        }
    }
    
    // MARK: Gpx
    private func saveUserLocationToGpx() {
        guard let userLocation = userLocation else { return }
        GpxManager.saveGpxFile(userLocation.latitude, longitude: userLocation.longitude)
    }
    
    // MARK: Favorites
    func addFavorite(coordinate coordinate: CLLocationCoordinate2D, name: String? = nil) {
        let favorite = Favorite(coordinate: coordinate, name: name)
        favorites?.append(favorite)
    }
    
    func removeFavorite(favorite: Favorite) {
        guard let favorites = favorites else { return }
        if let index = favorites.indexOf(favorite) {
            self.favorites!.removeAtIndex(index)
        }
    }
}
