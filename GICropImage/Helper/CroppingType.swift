//
//  CroppingType.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 26.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit


protocol ShapeDrawing {
    func draw()
}

protocol CroppingShapeProperties: ShapeDrawing  {
    
    var blurFilterMask      : CAShapeLayer {get}
    var blurFilterOrigin    : CGPoint {get}
}

protocol CircleCroppingShapeProperties: CroppingShapeProperties {
    var ovalRectMask  : CAShapeLayer {get}
    var ovalRect      : CGRect {get}
    var blurFilterDiameter  : CGFloat {get}
}




struct CircleCropping : CircleCroppingShapeProperties {
   
    var superView: UIView?
    
    var blurFilterMask: CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.fillRule = .evenOdd
        maskLayer.frame    = (self.superView?.bounds)!
        maskLayer.opacity  = 0.8;
        return maskLayer
    }
    
    var blurFilterOrigin: CGPoint {
        return (self.superView?.center)!
    }
    
    var blurFilterDiameter: CGFloat {
        return min((self.superView?.bounds.size.width)!, (self.superView?.bounds.size.height)!) * 0.95
    }
    
    var ovalRectMask: CAShapeLayer {
        let ovalRectLayer = CAShapeLayer()
        ovalRectLayer.strokeColor = UIColor.white.withAlphaComponent(0.8).cgColor
        ovalRectLayer.fillColor   = UIColor.clear.cgColor;
        ovalRectLayer.lineWidth   = 3;
        return ovalRectLayer
    }
    
    var ovalRect: CGRect {
        return CGRect(x: self.blurFilterOrigin.x - (blurFilterDiameter / 2),
                      y: self.blurFilterOrigin.y - (blurFilterDiameter / 2),
                      width: self.blurFilterDiameter,
                      height: self.blurFilterDiameter)
    }
    
    func draw() {
        
    
    }
    
}




