//
//  TripFunctions.swift
//  itineray-app
//
//  Created by karim metawea on 4/14/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation
class TripFunctions {
    static func createTrip(trip:TripModel){
        DataModel.trips.append(trip)
    }
    static func readTrips(completion:@escaping ()->()){
        DispatchQueue.global(qos: .userInteractive).async {
            if DataModel.trips.count == 0 {
                DataModel.trips.append(TripModel(title: "bali vacation"))
                DataModel.trips.append(TripModel(title: "greece trip"))
                DataModel.trips.append(TripModel(title: "canada immigration"))
            }
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    static func updateTrip(trip:TripModel){
        
    }
    static func deleteTrip(trip:TripModel){
        
    }
}
