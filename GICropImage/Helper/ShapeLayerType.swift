//
//  ShapeType.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 28.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

enum ShapeLayerType {
    case circle
    case square
}

protocol ShapeLayerTargetProperties {
    var getLayerType    : GeneralShapeLayerProperties {get}
    var colorProperties : GICropImageOptionsProtocol  {get}
}

enum ShapeLayerTarget {
    case circle(view: UIView, prop: GICropImageOptionsProtocol)
    case square(view: UIView, prop: GICropImageOptionsProtocol)
}

extension ShapeLayerTarget : ShapeLayerTargetProperties {
    
    var colorProperties: GICropImageOptionsProtocol {
        switch self {
        case .circle(_,let prop):
            return prop
        case .square(_,let prop):
            return prop
        }
    }
    
    var getLayerType: GeneralShapeLayerProperties {
        switch self {
        case .circle(let view,_):
            let circleShapeLayer = CircleShapeLayer(options: colorProperties, superView: view)
            return circleShapeLayer
        case .square(let view,_):
            let squareShapeLayer = SquareShapeLayer(options: colorProperties, superView: view)
            return squareShapeLayer
        }
    }
    
}
