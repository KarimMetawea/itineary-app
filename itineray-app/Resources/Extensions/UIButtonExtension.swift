//
//  UIButtonExtension.swift
//  itineray-app
//
//  Created by karim metawea on 4/21/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit
extension UIButton {
    func roundAndMakeShadow(){
        layer.cornerRadius = self.frame.height / 2
        layer.borderColor = Theme.tintColor?.cgColor
        layer.borderWidth = 3
//        layer.shadowOpacity = 0.50
        
//        layer.shadowOffset = CGSize(width: 0, height: 10)
//        layer.shadowColor = Theme.accentColor?.cgColor
    }
}
