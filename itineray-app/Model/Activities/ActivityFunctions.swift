//
//  ActivityFunctions.swift
//  itineray-app
//
//  Created by karim metawea on 5/7/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation
class ActivityFunctions {
    
    static func createActivity(tripIndex:Int,dayIndex:Int,activity:ActivityModel){
       DataModel.trips[tripIndex].days[dayIndex].activities.append(activity)
    
    }
    
    
    
}
