//
//  CroppingType.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 26.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit


protocol ShapeLayerDrawing {
    func draw()
}

protocol GeneralShapeLayerProperties: ShapeLayerDrawing  {
    var superView           : UIView        {get set}
    var blurFilterMask      : CAShapeLayer  {get}
    var blurFilterOrigin    : CGPoint       {get}
    var blurFilterDiameter  : CGFloat       {get}
}

extension GeneralShapeLayerProperties {
    internal var blurFilterMask : CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.actions = [
            "path" : NSNull()
        ]
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.fillRule = .evenOdd
        maskLayer.frame    = superView.bounds
        maskLayer.opacity  = 0.8;
        return maskLayer
    }
    
    internal var blurFilterOrigin: CGPoint {
        return (self.superView.center)
    }
    
    internal var blurFilterDiameter: CGFloat {
        return min((self.superView.bounds.size.width), (self.superView.bounds.size.height)) * 0.95
    }
}

protocol CircleShapeLayerProperties: GeneralShapeLayerProperties {
    var ovalRectMask        : CAShapeLayer    {get}
    var ovalRect            : CGRect          {get}
}

protocol SquareShapeLayerProperties: GeneralShapeLayerProperties {
    var squareRectMask      : CAShapeLayer    {get}
    var squareRect          : CGRect          {get}
}



struct CircleShapeLayer : CircleShapeLayerProperties {
    var superView: UIView
    
    internal var ovalRectMask: CAShapeLayer {
        let ovalRectLayer = CAShapeLayer()
        ovalRectLayer.strokeColor = UIColor.white.withAlphaComponent(0.8).cgColor
        ovalRectLayer.fillColor   = UIColor.clear.cgColor;
        ovalRectLayer.lineWidth   = 3;
        return ovalRectLayer
    }
    
    internal var ovalRect: CGRect {
        return CGRect(x: self.blurFilterOrigin.x - (blurFilterDiameter / 2),
                      y: self.blurFilterOrigin.y - (blurFilterDiameter / 2),
                      width: self.blurFilterDiameter,
                      height: self.blurFilterDiameter)
    }
    
    func draw() {
        let blurFilterRadius: CGFloat = (blurFilterDiameter) * 0.5
        let ovalRect = CGRect(x: blurFilterOrigin.x - blurFilterRadius, y: blurFilterOrigin.y - blurFilterRadius, width: blurFilterDiameter, height: blurFilterDiameter)
        let blurRegionPath = CGMutablePath()
        blurRegionPath.addRect(self.superView.bounds, transform: .identity)
        blurRegionPath.addEllipse(in: ovalRect, transform: .identity)
        let ovalRegionPath     = UIBezierPath(ovalIn: ovalRect)
        
        let filterAreaLayer = blurFilterMask
        let ovalAreaLayer   = ovalRectMask
        
        filterAreaLayer.path = blurRegionPath
        ovalAreaLayer.path   = ovalRegionPath.cgPath
        
        self.superView.backgroundColor = UIColor.clear;
        self.superView.layer.addSublayer(filterAreaLayer)
        self.superView.layer.addSublayer(ovalAreaLayer)
    }
}


struct SquareShapeLayer : SquareShapeLayerProperties {
    var superView: UIView
    
    var squareRectMask: CAShapeLayer {
        let ovalRectLayer = CAShapeLayer()
        ovalRectLayer.strokeColor = UIColor.white.withAlphaComponent(0.8).cgColor
        ovalRectLayer.fillColor   = UIColor.clear.cgColor;
        ovalRectLayer.lineWidth   = 3;
        return ovalRectLayer
    }
    
    var squareRect: CGRect {
        return CGRect(x: self.blurFilterOrigin.x - (blurFilterDiameter / 2),
                      y: self.blurFilterOrigin.y - (blurFilterDiameter / 2),
                      width: self.blurFilterDiameter,
                      height: self.blurFilterDiameter)
    }
    
    func draw() {
        let blurFilterRadius: CGFloat = (blurFilterDiameter) * 0.5
        let squareRect = CGRect(x: blurFilterOrigin.x - blurFilterRadius, y: blurFilterOrigin.y - blurFilterRadius, width: blurFilterDiameter, height: blurFilterDiameter)
        let blurRegionPath = CGMutablePath()
        blurRegionPath.addRect(self.superView.bounds, transform: .identity)
        blurRegionPath.addRect(squareRect)
        let squareRegionPath = UIBezierPath(rect: squareRect)
        
        let filterAreaLayer   = blurFilterMask
        let squareAreaLayer   = squareRectMask
        
        
        filterAreaLayer.path   = blurRegionPath
        squareAreaLayer.path   = squareRegionPath.cgPath
        
        self.superView.backgroundColor = UIColor.clear;
        self.superView.layer.addSublayer(filterAreaLayer)
        self.superView.layer.addSublayer(squareAreaLayer)
    }
}
