//
//  RoundedButton.swift
//  itineray-app
//
//  Created by karim metawea on 5/7/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = self.frame.height / 2
        layer.borderColor = Theme.tintColor?.cgColor
        layer.borderWidth = 3
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
