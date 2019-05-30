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
    case s32x32
    case s64x64
    case s128x128
    case s256x256
    case s512x512
    case s1024x1024
    case customSize(size: CGFloat)
    
}

extension ImageScaleSize: RawRepresentable {
    typealias RawValue = CGSize
    
    init?(rawValue: CGSize) {
        return nil
    }
    
    var rawValue: CGSize {
        switch self {
        case .s32x32:
            return CGSize(width: 32, height: 32)
        case .s64x64:
            return CGSize(width: 64, height: 64)
        case .s128x128:
            return CGSize(width: 128, height: 128)
        case .s256x256:
            return CGSize(width: 256, height: 256)
        case .s512x512:
            return CGSize(width: 512, height: 512)
        case .s1024x1024:
            return CGSize(width: 1024, height: 1024)
        case .customSize(let size): do {
            return CGSize(width: size, height: size)
            }
        }
    }

}
