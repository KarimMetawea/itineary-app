//
//  UITextFieldExtension.swift
//  itineray-app
//
//  Created by karim metawea on 5/5/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit
extension UITextField {
    
    ///            making warning for the user if the text field is empty
    var hasValue:Bool {
        
        guard text == "" else {return true}
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        label.text = "❗️"
        label.font = UIFont(name: "Avenir", size: 20)
        self.rightView = label
        self.layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        self.layer.borderWidth = 2
        
        //            controlling the mode of the view in the tripNameTextField
        self.rightViewMode = .unlessEditing
        return false
    }
}
