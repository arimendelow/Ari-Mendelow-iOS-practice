//
//  MaterialView.swift
//  DreamLister
//
//  Created by Ari Mendelow on 3/13/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import UIKit

private var materialKey = true

extension UIView {

    @IBInspectable var materialDesign: Bool {
        
        get {
            
            return materialKey
            
        } set {
            
            materialKey = newValue
            
            if materialKey {
                
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 257/255, green: 257/255, blue: 257/255, alpha: 1.0).cgColor
                
            } else {
                
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
                
            }
            
        }

    }

}
