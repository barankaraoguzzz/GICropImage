//
//  GIImageCropVC.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 26.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

protocol GICropImageVCDelegate {
    func getImage(_ croppedImage: UIImage)
}

open class GIImageCropVC: UIViewController {

    @IBOutlet fileprivate weak var scrollView   : GIZoomingScrollView!
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var bottomView   : UIView!
    @IBOutlet fileprivate weak var choiceButton : UIButton!
    @IBOutlet fileprivate weak var cancelButton : UIButton!
    
    var delegate            : GICropImageVCDelegate?
    var options             = GICropImageOptions()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.configureWithImage(UIImage(named: "prience_of_persia")!, GIOptions: options)
        self.drawShapes(options)    
    }
    
   
    @IBAction func choiceButtonAct(_ sender: Any) {
        if (delegate != nil) {
            delegate?.getImage(self.getCroppedImage(options))
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButtonAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func drawShapes(_ options: GICropImageOptionsProtocol!) {
        self.getGIShapeLayerTarget(options).getLayerType.draw()
    }
    
    func getCroppedImage(_ options: GICropImageOptionsProtocol) -> UIImage {
         return self.getGIShapeLayerTarget(options).cropImageCalculater.croppingImage(self.scrollView,
                                                                                      imgView: self.scrollView.getImageView())
    }
    
    
    func getGIShapeLayerTarget(_ options: GICropImageOptionsProtocol!) -> GICroppingTarget {
        switch options.shapeLayerType {
        case .circle:
            return GICroppingTarget.circle(view: self.containerView, prop: options)
        case .square:
            return GICroppingTarget.square(view: self.containerView, prop: options)
        }
    }
}
