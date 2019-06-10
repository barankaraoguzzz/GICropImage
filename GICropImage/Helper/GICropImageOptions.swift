//
//  GICropImageOptions.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 29.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

protocol GICropImageOptionsProtocol {
    var backgroundFillColor : UIColor           {get set}
    var backgroundOpacity   : Float             {get set}
    var maskLayerStrokeColor: UIColor           {get set}
    var maskLayerLineWitdh  : CGFloat           {get set}
    var shapeLayerType      : GICroppingType    {get set}
    var imageScaleSize      : ImageScaleSize    {get set}
    var isImageScale        : Bool              {get set}
}

final class GICropImageOptions : GICropImageOptionsProtocol {
    var backgroundFillColor : UIColor               = UIColor.black
    var backgroundOpacity   : Float                 = 0.8
    var maskLayerStrokeColor: UIColor               = UIColor.white.withAlphaComponent(0.8)
    var maskLayerLineWitdh  : CGFloat               = 3.0
    var shapeLayerType      : GICroppingType        = .circle
    var imageScaleSize      : ImageScaleSize        = .s1024x1024
    var isImageScale        : Bool                  = true
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
