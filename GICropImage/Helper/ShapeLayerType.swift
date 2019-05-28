//
//  ShapeType.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 28.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit


protocol ShapeLayerTargetProperties {
    var getLayerType : GeneralShapeLayerProperties {get}
}

enum ShapeLayerTarget {
    case circle(view: UIView)
    case square(view: UIView)
}

extension ShapeLayerTarget : ShapeLayerTargetProperties {
    
    var getLayerType: GeneralShapeLayerProperties {
        switch self {
        case .circle(let view):
            let circleShapeLayer = CircleShapeLayer(superView: view)
            return circleShapeLayer
        case .square(let view):
            let circleShapeLayer = CircleShapeLayer(superView: view)
            return circleShapeLayer
        }
    }
    
}
