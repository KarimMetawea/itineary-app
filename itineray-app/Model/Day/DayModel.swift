//
//  DayModel.swift
//  itineray-app
//
//  Created by karim metawea on 4/28/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation

struct DayModel {
    var id:String
    var title:Date = Date()
    var subTitle:String = ""
    var activities = [ActivityModel]()
    
    init(title:Date,subTitle:String,activities:[ActivityModel]? = nil) {
        id = UUID().uuidString
        self.title = title
        self.subTitle = subTitle
        if let activities = activities{
            self.activities = activities
        }
    }
}
