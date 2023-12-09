//
//  UIView + Extension .swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/9/23.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5
    }
}
