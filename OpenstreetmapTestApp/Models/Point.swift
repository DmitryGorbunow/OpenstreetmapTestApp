//
//  Point.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/7/23.
//

import Foundation
import CoreLocation

struct Coordinate: Codable {
    let lat: Double
    let long: Double
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

struct Point: Codable {
    let name: String
    let date: String
    let time: String
    let image: String
    let locationType: String
    let coordinate: Coordinate
}
