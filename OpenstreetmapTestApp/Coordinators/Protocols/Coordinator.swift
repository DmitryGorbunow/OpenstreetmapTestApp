//
//  Coordinator.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/9/23.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
