//
//  Example.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 29.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

class Example: UIViewController{

    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func goCrop(_ sender: Any) {
     
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GIImageCropVC") as? GIImageCropVC
        let options = GICropImageOptions()
        options.shapeLayerType = .square
        vc?.options = options
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}

extension Example : GICropImageVCDelegate {
    func getImage(_ croppedImage: UIImage) {
        testImageView.image = croppedImage
    }
    
}
