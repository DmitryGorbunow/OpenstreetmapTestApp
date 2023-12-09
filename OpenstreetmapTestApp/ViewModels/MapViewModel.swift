//
//  MapViewModel.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/9/23.
//

import Foundation

protocol MapViewModelProtocol {
    var coordinator : AppCoordinator? { get }
    var annotations: [PointAnnotation] { get }
    func createAnnotations()
}

final class MapViewModel: MapViewModelProtocol {
    
    // MARK: - Properties
    
    weak var coordinator : AppCoordinator?
    private let dataService = DataService()
    private var dataPoints: [Point] = []
    var annotations: [PointAnnotation] = []
    
    // MARK: - Private Methods
    
    private func fetchData() {
        dataService.fectData { [weak self] result in
            switch result {
            case .success(let points):
                self?.dataPoints = points
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Public Methods
    
    func createAnnotations() {
        fetchData()
        for point in dataPoints {
            let annotation = PointAnnotation(point: point, image: point.image, name: point.name, date: point.date, time: point.time, locationType: point.locationType)
            annotations.append(annotation)
        }
    }
}
