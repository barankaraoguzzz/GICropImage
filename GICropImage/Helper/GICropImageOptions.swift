//
//  GICropImageOptions.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 29.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

protocol GICropImageOptionsProtocol {
    var backgroundFillColor : UIColor        {get set}
    var backgroundOpacity   : Float          {get set}
    var maskLayerStrokeColor: UIColor        {get set}
    var maskLayerLineWitdh  : CGFloat        {get set}
    var shapeLayerType      : ShapeLayerType {get set}
}

final class GICropImageOptions : GICropImageOptionsProtocol {
    var backgroundFillColor : UIColor = UIColor.black
    var backgroundOpacity   : Float   = 0.8
    var maskLayerStrokeColor: UIColor = UIColor.white.withAlphaComponent(0.8)
    var maskLayerLineWitdh  : CGFloat = 3.0
    var shapeLayerType      : ShapeLayerType = .circle
}
