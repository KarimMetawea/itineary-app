//
//  TripModel.swift
//  itineray-app
//
//  Created by karim metawea on 4/14/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit
class TripModel {
    var id :UUID
    var title:String!
    var image:UIImage?
    
    
    init(title:String,image:UIImage?=nil) {
        id = UUID()
        self.title = title
        self.image = image
    }
}
