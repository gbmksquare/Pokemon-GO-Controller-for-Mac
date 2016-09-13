//
//  GpxManager.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 26..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa

class GpxManager {
    class func saveGpxFile(_ latitude: Double, longitude: Double) {
        let filePath = (NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .allDomainsMask, true).first)! + "/pokemon_location.gpx"
        let fileUrl = URL(fileURLWithPath: filePath)
        let xmlContent = "<gpx creator=\"Xcode\" version=\"1.1\"><wpt lat=\"\(latitude)\" lon=\"\(longitude)\"><name>PokemonLocation</name></wpt></gpx>"
        do {
            try xmlContent.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
}
