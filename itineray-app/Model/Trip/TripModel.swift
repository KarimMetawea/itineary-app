//
//  TripModel.swift
//  itineray-app
//
//  Created by karim metawea on 4/14/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

struct TripModel {
    
    var id :UUID
    var title:String!
    var image:UIImage?
    var days = [DayModel](){
        didSet {
            days = days.sorted(by: { $0.title < $1.title })
        }
    }
    
    
    init(title:String,image:UIImage?=nil,days:[DayModel]? = nil) {
        id = UUID()
        self.title = title
        self.image = image
        if let days = days {
         self.days = days
        }
    }
}
