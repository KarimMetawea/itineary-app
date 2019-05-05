//
//  DayFuctions.swift
//  itineray-app
//
//  Created by karim metawea on 5/5/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation

class DayFunctions {
    static func createDay(tripIndex:Int,day:DayModel){
        DataModel.trips[tripIndex].days.append(day)
    }
    
    
//    static func readDays(tripIndex:Int ,completion:@escaping ()->()){
//
//        DispatchQueue.global(qos: .userInteractive).async {
//
//            if DataModel.trips.count == 0 {
//                DataModel.trips[tripIndex].days = MockData.createMockDayModelData()
//            }
//
//            DispatchQueue.main.async {
//                completion()
//            }
//
//        }
//
//    }
    
    static func readDaysById(tripIndex:Int, id:String,completion:@escaping (DayModel?)->()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let day = DataModel.trips[tripIndex].days.first(where: { (day) -> Bool in
                day.id == id
            })
            DispatchQueue.main.async {
                completion(day)
            }
        }
        
    }
    
    
    static func updateDay(index:Int,name:String){
        DataModel.trips[index].title = name
        
    }
    
    static func deleteDay(index:Int){
        DataModel.trips.remove(at: index)
    }
}

