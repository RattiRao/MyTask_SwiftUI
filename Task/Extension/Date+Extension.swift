//
//  Date+Extension.swift
//  Task
//
//  Created by Prithvi Rao Ratti on 04/08/23.
//

import Foundation

extension Date {
    func getFormattedTaskDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: self)
    }
}
