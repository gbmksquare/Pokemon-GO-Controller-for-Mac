//
//  GpxManager.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 26..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa

class GpxManager {
    class func saveGpxFile(latitude: Double, longitude: Double) {
        guard let filePath = NSSearchPathForDirectoriesInDomains(.DownloadsDirectory, .AllDomainsMask, true).first?.stringByAppendingString("/pokemon_location.gpx") else { return }
        let fileUrl = NSURL.fileURLWithPath(filePath)
        let xmlContent = "<gpx creator=\"Xcode\" version=\"1.1\"><wpt lat=\"\(latitude)\" lon=\"\(longitude)\"><name>PokemonLocation</name></wpt></gpx>"
        do {
            try xmlContent.writeToURL(fileUrl, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            print(error)
        }
    }
}
