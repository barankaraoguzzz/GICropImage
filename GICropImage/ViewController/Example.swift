//
//  Example.swift
//  GICropImage
//
//  Created by Baran Karaoğuz on 29.05.2019.
//  Copyright © 2019 Baran Karaoğuz. All rights reserved.
//

import UIKit

protocol Configure {
    var fillColor : UIColor {get set}
    var with      : Int     {get set}
}

class Example: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func goCrop(_ sender: Any) {
     
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GIImageCropVC") as? GIImageCropVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        
    }
}
