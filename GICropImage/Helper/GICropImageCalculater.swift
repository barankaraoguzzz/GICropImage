//
//  GIImageCrop.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 30.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

protocol GICropImageCalculater {
    func croppingImage(_ imgView: UIImageView) -> UIImage
    func scaleImage(_ img: UIImage, size: CGSize) -> UIImage
}

extension GICropImageCalculater {
    func scaleImage(_ img: UIImage, size: CGSize) -> UIImage? {
        let newSize = CGSize(width: size.width, height: size.height)
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

enum ImageScaleSize {
    
}
