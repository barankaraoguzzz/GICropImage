//
//  GIZoomingImageCalculater.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 30.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

//Mark -> Protocol
protocol GIZoomingImageCalculaterProtocol {
    func contentCenter(_ scrollView: UIScrollView) -> CGPoint
    func contentOffSetCenter(_ scrollView: UIScrollView) -> CGPoint
    func centerWith(_ size : CGSize) -> CGPoint
    func visibleSizes(_ scrollView: UIScrollView) -> CGSize
    func validCGSize(size: CGSize) -> Bool
    func setCenterImageView(_ scroolView: UIScrollView, imgView: UIImageView)
    func centerScrollViewContents(_ scrollView: UIScrollView)
}

extension GIZoomingImageCalculaterProtocol {
    
    func contentCenter(_ scrollView: UIScrollView) -> CGPoint {
        return CGPoint(x: scrollView.contentSize.width / 2, y: scrollView.contentSize.height / 2)
    }
    
    func contentOffSetCenter(_ scrollView: UIScrollView) -> CGPoint {
        return CGPoint(x: (scrollView.contentSize.width - scrollView.frame.size.width) / 2, y: (scrollView.contentSize.height - scrollView.frame.size.height) / 2)
    }
    
    func centerWith(_ size : CGSize) -> CGPoint{
        return CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    func visibleSizes(_ scrollView: UIScrollView) -> CGSize {
        let size = scrollView.bounds.size
        return CGSize(width: size.width - scrollView.contentInset.left - scrollView.contentInset.right,
                      height: size.height - scrollView.contentInset.top - scrollView.contentInset.bottom)
        
    }
    
    func validCGSize(size: CGSize) -> Bool {
        return size.width > 0 && size.height > 0
    }
    
    func setCenterImageView(_ scroolView: UIScrollView, imgView: UIImageView) {
        var center = imgView.center
        if (scroolView.contentSize.width < self.visibleSizes(scroolView).width)
        {
            center.x = self.centerWith(self.visibleSizes(scroolView)).x
        }
        if (scroolView.contentSize.height < self.visibleSizes(scroolView).height)
        {
            center.y = self.centerWith(self.visibleSizes(scroolView)).y
        }
        imgView.center = center
    }
    
    func centerScrollViewContents(_ scrollView: UIScrollView) {
        
        if let imgView = scrollView.delegate?.viewForZooming!(in: scrollView) as? UIImageView {
            if let img = imgView.image {
                if (!self.validCGSize(size: imgView.frame.size) && !self.validCGSize(size: img.size)) {
                    return
                }
                imgView.center = self.contentCenter(scrollView)
                self.setCenterImageView(scrollView, imgView: imgView)
            }
        }
    }
    
}

protocol GIImageCalculateContentSizeProtocol {
    func calculateAspectFillSize(aspectRatio: CGSize, minumumSize: CGSize) -> CGSize
}

extension GIImageCalculateContentSizeProtocol {
    func calculateAspectFillSize(aspectRatio: CGSize, minumumSize: CGSize) -> CGSize {
        var aspectFillSize = CGSize(width: minumumSize.width, height: minumumSize.height)
        let mW = minumumSize.width  / aspectRatio.width
        let mH = minumumSize.height / aspectRatio.height
        
        if mH > mW
        {
            aspectFillSize.width = mH * aspectRatio.width
        }
        else if mW > mH
        {
            aspectFillSize.height = mW * aspectRatio.height
        }
        
        return aspectFillSize
    }
}

