//
//  PointAnnotation.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/7/23.
//

import Foundation
import MapKit

final class PointAnnotation: MKPointAnnotation {
    private(set) var point: Point
    var image: String
    var name: String
    var date: String
    var time: String
    var locationType: String
    
    init(point: Point, image: String, name: String, date: String, time: String, locationType: String) {
        self.point = point
        self.image = image
        self.name = name
        self.date = date
        self.time = time
        self.locationType = locationType
        super.init()
        self.coordinate = point.coordinate.locationCoordinate
    }
}
