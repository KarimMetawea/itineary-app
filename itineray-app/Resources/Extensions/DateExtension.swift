//
//  DatePickerExtension.swift
//  itineray-app
//
//  Created by karim metawea on 5/5/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import Foundation

extension Date {
    func addDay(numberOfDays:Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: Date())!
    }
    
    func mediumDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
