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
    
    static func deleteActivity(tripIndex:Int,dayIndex:Int,activity:ActivityModel){
       var day = DataModel.trips[tripIndex].days[dayIndex]
        if let index = day.activities.firstIndex(where: { (model) -> Bool in
            model.id == activity.id
        }){
            day.activities.remove(at: index)
        }
    }
    
    static func updateActivity(tripIndex:Int,oldDayIndex:Int,newDayIndex:Int,activity:ActivityModel){
        if oldDayIndex != newDayIndex {
            let index = DataModel.trips[tripIndex].days[newDayIndex].activities.count - 1
            reorderActivity(tripIndex: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: index, activity: activity)
        }else{
            
            let index = DataModel.trips[tripIndex].days[oldDayIndex].activities.firstIndex { (model) -> Bool in
                model.id == activity.id
            }
            DataModel.trips[tripIndex].days[oldDayIndex].activities[index!] = activity
            
        }
        
        
        }
    
    static func reorderActivity(tripIndex:Int,oldDayIndex:Int,newDayIndex:Int,newActivityIndex:Int,activity:ActivityModel){
       
        let oldDayModel = DataModel.trips[tripIndex].days[oldDayIndex]
        let oldActivityIndex = oldDayModel.activities.firstIndex { (model) -> Bool in
            model.id == activity.id
        }
        DataModel.trips[tripIndex].days[oldDayIndex].activities.remove(at: oldActivityIndex!)
        
        DataModel.trips[tripIndex].days[newDayIndex].activities.insert(activity,at: newActivityIndex)
        
    }
    
    
}
