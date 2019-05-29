//
//  GIZoomingScrollView.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 26.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

class GIZoomingScrollView: UIScrollView {

    fileprivate var imageView : UIImageView?
    
    func configureWithImage(_ image: UIImage) {
        if ((imageView) != nil) {
           self.imageView?.image = image
        } else {
            self.imageView = UIImageView()
            if let imgView = self.imageView {
                self.setupImageView(imgView: imgView)
                imgView.image = image
            }
        }
        self.addSubview(self.imageView!)
        self.configureScrollView()
        self.configureSize(imgView: self.imageView!)
    }
    
    private func setupImageView(imgView: UIImageView) {
        imgView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        imgView.isUserInteractionEnabled = true
        imgView.contentMode              = .scaleAspectFill
        imgView.clipsToBounds            = false
        imgView.backgroundColor          = UIColor.black
    }
    
    private func configureScrollView() {
        self.delegate = self
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
        self.minimumZoomScale               = 1.0
        self.maximumZoomScale               = 5.0
    }
    
    private func configureSize(imgView : UIImageView) {
        let aspectFillSize = self.calculateAspectFillSize(aspectRatio: (imgView.image?.size)!, minumumSize: imgView.frame.size)
        let newRect        = CGRect(x: imgView.center.x, y: imgView.center.y, width: aspectFillSize.width, height: aspectFillSize.height)
        imgView.frame      = newRect
        
        self.contentSize   = imgView.frame.size
        imgView.center     = self.contentCenter()
        self.contentOffset = self.contentOffSetCenter()
        self.setCenterImageView(imgView)
    }
    
   
}

extension GIZoomingScrollView : UIScrollViewDelegate {

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerScrollViewContents()
    }
  
}

//Mark -> Helper Func
extension GIZoomingScrollView {
    
    private func calculateAspectFillSize(aspectRatio: CGSize, minumumSize: CGSize) -> CGSize {
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
    
    private func contentCenter() -> CGPoint {
        return CGPoint(x: self.contentSize.width / 2, y: self.contentSize.height / 2)
    }
    
    private func contentOffSetCenter() -> CGPoint {
        return CGPoint(x: (self.contentSize.width - self.frame.size.width) / 2, y: (self.contentSize.height - self.frame.size.height) / 2)
    }
   
    private func centerWith(_ size : CGSize) -> CGPoint{
        return CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    private func visibleSizes() -> CGSize {
        let size = self.bounds.size
        return CGSize(width: size.width - self.contentInset.left - self.contentInset.right, height: size.height - self.contentInset.top - self.contentInset.bottom)
        
    }
    
    private func validCGSize(size: CGSize) -> Bool {
        return size.width > 0 && size.height > 0
    }
    
    private func setCenterImageView(_ imgView: UIImageView) {
        var center = imgView.center
        if (self.contentSize.width < self.visibleSizes().width)
        {
            center.x = self.centerWith(self.visibleSizes()).x
        }
        if (self.contentSize.height < self.visibleSizes().height)
        {
            center.y = self.centerWith(self.visibleSizes()).y
        }
        imgView.center = center
    }
    
    private func centerScrollViewContents() {
        
        if let imgView = self.delegate?.viewForZooming!(in: self) as? UIImageView {
            if let img = imgView.image {
                if (!self.validCGSize(size: imgView.frame.size) && !self.validCGSize(size: img.size)) {
                    return
                }
                imgView.center = self.contentCenter()
                self.setCenterImageView(imgView)
            }
        }
    }
}
