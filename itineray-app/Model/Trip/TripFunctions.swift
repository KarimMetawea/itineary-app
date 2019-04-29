//
//  TripFunctions.swift
//  itineray-app
//
//  Created by karim metawea on 4/14/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit
class TripFunctions {
    static func createTrip(trip:TripModel){
        DataModel.trips.append(trip)
    }
    
    
    static func readTrips(completion:@escaping ()->()){
        
        DispatchQueue.global(qos: .userInteractive).async {
            if DataModel.trips.count == 0 {
                DataModel.trips = MockData.createMockTripModelData()
            }
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    static func updateTrip(index:Int,name:String,image:UIImage?){
        DataModel.trips[index].title = name
        DataModel.trips[index].image = image
    }
    static func deleteTrip(index:Int){
        DataModel.trips.remove(at: index)
    }
}
