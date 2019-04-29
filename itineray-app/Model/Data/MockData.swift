//
//  MockData.swift
//  itineray-app
//
//  Created by karim metawea on 4/30/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation

class MockData {
    static func createMockTripModelData() -> [TripModel]{
        var trips = [TripModel]()
        trips.append(TripModel(title: "trip to thailand", image: nil, days: createMockDayModelData()))
        trips.append(TripModel(title: "trip to japan", image: nil, days: createMockDayModelData()))
        trips.append(TripModel(title: "trip to iceland", image: nil, days: createMockDayModelData()))
        
        return trips
    }
    
    
    
    
    static func createMockDayModelData() -> [DayModel]{
        var days = [DayModel]()
        days.append(DayModel(title: "May 20", subTitle: "first Day", activities: createMockActivityModelData()))
        days.append(DayModel(title: "May 21", subTitle: "exploring Day", activities: createMockActivityModelData()))
        
        days.append(DayModel(title: "May 22", subTitle: "safari day", activities: createMockActivityModelData()))
        
        return days
    }
    
    static func createMockActivityModelData() -> [ActivityModel]{
        var activities = [ActivityModel]()
        activities.append(ActivityModel(title: "go to the airport", subTitle: "2 hrs", activity: ActivityType.flight, image: nil))
        
        activities.append(ActivityModel(title: "having some sleep", subTitle: "3 hrs", activity: ActivityType.hotel, image: nil))
        
        activities.append(ActivityModel(title: "having launch", subTitle: "30 minutes", activity: ActivityType.food, image: nil))
        
        return activities
    }
}
