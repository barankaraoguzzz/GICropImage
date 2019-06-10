//
//  GIZoomingScrollView.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 26.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

class GIZoomingScrollView: UIScrollView, GIImageCalculateContentSizeProtocol, GIZoomingImageCalculaterProtocol {

    fileprivate var imageView       : UIImageView?
    fileprivate var options         : GICropImageOptionsProtocol?
    fileprivate var circleCropper   : GISquareCrop?
    
    func configureWithImage(_ image: UIImage, GIOptions: GICropImageOptionsProtocol) {
        //Initials
        options = GIOptions
        
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
        imgView.center     = self.contentCenter(self)
        self.contentOffset = self.contentOffSetCenter(self)
        self.setCenterImageView(self, imgView: imgView)
    }
    
}

//Mark -> ScroolView Delegate
extension GIZoomingScrollView : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerScrollViewContents(self)
    }
    
}

//Mark -> Public Properties
extension GIZoomingScrollView {
    func getImageView() -> UIImageView {
        return self.imageView!
    }
}


