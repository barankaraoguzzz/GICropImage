//
//  GIImageCropVC.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 26.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

class GIImageCropVC: UIViewController {

    @IBOutlet weak var scrollView   : GIZoomingScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomView   : UIView!
    @IBOutlet weak var choiceButton : UIButton!
    @IBOutlet weak var cancelButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.configureWithImage(UIImage(named: "prience_of_persia")!)
        
        var options : GICropImageOptionsProtocol? = GICropImageOptions()
        options?.backgroundFillColor = UIColor.red
        options?.shapeLayerType = .square
        self.drawShapes(options)
        
    }

    func drawShapes(_ options: GICropImageOptionsProtocol!) {
        switch options.shapeLayerType {
        case .circle:
            ShapeLayerTarget.circle(view: self.containerView, prop: options).getLayerType.draw()
        case .square:
            ShapeLayerTarget.square(view: self.containerView, prop: options).getLayerType.draw()
        }
    }
}
