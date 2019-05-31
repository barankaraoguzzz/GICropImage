//
//  GIImageCrop.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 30.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

protocol GICropImageCalculater {
    func croppingImage(_ scroolView: UIScrollView, img: UIImage) -> UIImage
    func scaleImage(_ img: UIImage) -> UIImage?
    var options : GICropImageOptionsProtocol {get}
}

extension GICropImageCalculater {
    func scaleImage(_ img: UIImage) -> UIImage? {
        let newSize = options.imageScaleSize.rawValue
        UIGraphicsBeginImageContext(newSize)
        img.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = scaledImage {
            return image
        }
        return nil
    }
}

struct GICircleCrop: GICropImageCalculater, GIImageCalculateContentSizeProtocol {
    
    var options: GICropImageOptionsProtocol
    
    func croppingImage(_ scroolView: UIScrollView, img: UIImage) -> UIImage {
        
        var zoomingRect = CGRect()
        let zoomScale   = img.size.height / self.calculateAspectFillSize(aspectRatio: img.size,
                                                                         minumumSize: img.size).height
        zoomingRect.origin.x    = abs(scroolView.contentOffset.x * zoomScale)
        zoomingRect.origin.y    = abs(scroolView.contentOffset.y * zoomScale)
        zoomingRect.size.width  = abs(scroolView.bounds.size.width  * zoomScale)
        zoomingRect.size.height = abs(scroolView.bounds.size.height * zoomScale)
        
        UIGraphicsBeginImageContextWithOptions(zoomingRect.size, false, 0.0)
        let drawingCGPoint = CGPoint(x: -zoomingRect.origin.x, y: -zoomingRect.origin.y)
        img.draw(at: drawingCGPoint,
                 blendMode: .copy,
                 alpha: 1.0)
        
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        guard let croppedResultImage = croppedImage else {
            print("⚠⚠ Image cropped transaction is failed ⚠⚠")
            fatalError()
        }
        
        if (options.isImageScale) {
            let scaledImage = self.scaleImage(croppedResultImage)
            guard let scaledResultImage = scaledImage else {
                print("⚠⚠ Image scaled transaction is failed ⚠⚠")
                fatalError()
            }
            return scaledResultImage
        }
        return croppedResultImage
    }

}
