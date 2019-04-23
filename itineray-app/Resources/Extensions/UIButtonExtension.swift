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
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = Theme.tintColor?.cgColor
    }
}
