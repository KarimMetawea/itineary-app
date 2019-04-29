//
//  ActivityModel.swift
//  itineray-app
//
//  Created by karim metawea on 4/30/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

struct ActivityModel {
    var id:String
    var title = ""
    var subTitle = ""
    var activityType: ActivityType
    var photo: UIImage?
    
    init(title:String,subTitle:String,activity:ActivityType,image:UIImage? = nil) {
        id = UUID().uuidString
        self.title = title
        self.subTitle = subTitle
        self.activityType = activity
        self.photo = image
        
    }
}
