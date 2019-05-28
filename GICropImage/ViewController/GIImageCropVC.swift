//
//  GIImageCropVC.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 26.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

class GIImageCropVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getShape(.circle(view: self.view)).draw()
        self.getShape(.square(view: self.view)).draw()
        
    }

    @discardableResult
    func getShape(_ shapeType: ShapeLayerTarget) -> GeneralShapeLayerProperties {
        return shapeType.getLayerType
    }
    
    
}
