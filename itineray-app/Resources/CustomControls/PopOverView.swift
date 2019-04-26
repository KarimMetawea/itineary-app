//
//  PopOverView.swift
//  itineray-app
//
//  Created by karim metawea on 4/23/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class PopOverView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.25
        self.layer.cornerRadius = 10
//                self.layer.borderWidth = 4
//                self.layer.borderColor = Theme.borderColor?.cgColor
    }

}
