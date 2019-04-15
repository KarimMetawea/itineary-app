//
//  TripModel.swift
//  itineray-app
//
//  Created by karim metawea on 4/14/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation
class TripModel {
    var id :String!
    var title:String!
    
    init(title:String) {
        id = UUID().uuidString
        self.title = title
    }
}
