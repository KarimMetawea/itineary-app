//
//  TripModel.swift
//  itineray-app
//
//  Created by karim metawea on 4/14/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation
class TripModel {
    var id :UUID
    var title:String!
    
    init(title:String) {
        id = UUID()
        self.title = title
    }
}
