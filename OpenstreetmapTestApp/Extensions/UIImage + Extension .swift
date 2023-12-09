//
//  UIImage + Extension .swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/8/23.
//

import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        let newSize = widthRatio > heightRatio ?
        CGSize(width: size.width * heightRatio, height: size.height * heightRatio) :
        CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func createCompositeImage(outerImage: UIImage?, innerImage: UIImage?) -> UIImage? {
        guard let outerImage = outerImage, let innerImage = innerImage else {
            return nil
        }
        
        let imageSize = CGSize(width: 60, height: 60)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        let outerImageRect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        let outerImageCenter = CGPoint(x: outerImageRect.midX, y: outerImageRect.midY - 4.5)
        
        outerImage.draw(in: outerImageRect)
        
        let innerImageSize = CGSize(width: 39, height: 39)
        let innerImageRect = CGRect(x: outerImageCenter.x - innerImageSize.width / 2,
                                    y: outerImageCenter.y - innerImageSize.height / 2,
                                    width: innerImageSize.width,
                                    height: innerImageSize.height)
        
        let circlePath = UIBezierPath(ovalIn: innerImageRect)
        circlePath.addClip()
        
        innerImage.draw(in: innerImageRect)
        
        let compositeImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return compositeImage
    }
}
