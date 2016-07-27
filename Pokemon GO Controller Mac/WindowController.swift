//
//  WindowController.swift
//  Pokemon GO Controller Mac
//
//  Created by BumMo Koo on 2016. 7. 26..
//  Copyright © 2016년 BumMo Koo. All rights reserved.
//

import Cocoa
import MapKit

class WindowController: NSWindowController {
    @IBOutlet weak var speedPopUpButton: NSPopUpButton!
    
    private var viewController: ViewController? {
        return contentViewController as? ViewController
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titleVisibility = .Hidden
        updateSpeedPopUpButton()
    }
    
    func updateSpeedPopUpButton() {
        if let viewController = viewController {
            speedPopUpButton.selectItemAtIndex(viewController.speed.rawValue)
        }
    }

    // MARK: Action
    @IBAction func handleAddFavorite(sender: NSButton) {
        guard let coordinate = viewController?.userLocation else { return }
        viewController?.favorites?.append(Favorite(coordinate: coordinate))
    }
    
    @IBAction func handleSpeedMenuChanged(sender: NSPopUpButton) {
        let index = sender.indexOfSelectedItem
        guard let speed = Speed(rawValue: index) else { return }
        viewController?.speed = speed
    }
    
    @IBAction func handleMapTypeChanged(sender: NSPopUpButton) {
        let index = sender.indexOfSelectedItem
        switch index {
        case 0: viewController?.mapView.mapType = .Standard
        case 1: viewController?.mapView.mapType = .Hybrid
        case 2: viewController?.mapView.mapType = .Satellite
        default: viewController?.mapView.mapType = .Standard
        }
    }
    
    @IBAction func handleMoveToActualLocation(sender: NSButton) {
        let mapView = viewController?.mapView
        guard let actualLocation = mapView?.userLocation.coordinate else { return }
        guard let span = mapView?.region.span else { return }
        let region = MKCoordinateRegion(center: actualLocation, span: span)
        viewController?.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func handleOpenPokeVision(sender: NSButton) {
        guard let coordinate = viewController?.userLocation else { return }
        let urlString = "https://pokevision.com/#/@\(coordinate.latitude),\(coordinate.longitude)"
        guard let url = NSURL(string: urlString) else { return }
        NSWorkspace.sharedWorkspace().openURL(url)
    }
}
