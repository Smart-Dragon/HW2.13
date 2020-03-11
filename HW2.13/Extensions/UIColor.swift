//
//  UIColor.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 11.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
    }
    
    convenience init(gray: Int, alpha: CGFloat) {
        self.init(red: CGFloat(gray)/255, green: CGFloat(gray)/255, blue: CGFloat(gray)/255, alpha: alpha)
    }
    
}
