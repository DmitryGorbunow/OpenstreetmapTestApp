//
//  AppCoordinator.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/9/23.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToMapPage()
    }
    
    func goToMapPage() {
        let mapViewModel = MapViewModel()
        mapViewModel.coordinator = self
        let mapViewController = MapViewController(viewModel: mapViewModel)
        navigationController.setViewControllers([mapViewController], animated: false)
    }
}

