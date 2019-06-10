//
//  ShapeType.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 28.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

enum GICroppingType {
    case circle
    case square
}

protocol GICroppingTargetProperties {
    var getLayerType            : GeneralShapeLayerProperties {get}
    var cropImageCalculater     : GICropImageCalculater       {get}
    var properties              : GICropImageOptionsProtocol  {get}
}

enum GICroppingTarget {
    case circle(view: UIView, prop: GICropImageOptionsProtocol)
    case square(view: UIView, prop: GICropImageOptionsProtocol)
}

extension GICroppingTarget : GICroppingTargetProperties {
    
    var properties: GICropImageOptionsProtocol {
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
            let circleShapeLayer = CircleShapeLayer(options: properties, superView: view)
            return circleShapeLayer
        case .square(let view,_):
            let squareShapeLayer = SquareShapeLayer(options: properties, superView: view)
            return squareShapeLayer
        }
    }
    
    var cropImageCalculater: GICropImageCalculater {
        switch self {
        case .circle(view: _, prop: _):
            //Mark : TO DO
            return GISquareCrop(options: properties)
        case .square(view: _, prop: _):
            return GISquareCrop(options: properties)
        }
    }
    
}
