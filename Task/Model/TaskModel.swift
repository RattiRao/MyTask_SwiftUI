//
//  TaskModel.swift
//  Task
//
//  Created by Prithvi Rao Ratti on 04/08/23.
//

import Foundation

struct TaskModel: Identifiable {
    var id: Int
    var title: String
    var desc: String
    var date: Date
    var isCompleted: Bool
    
    static func getTasks() -> [TaskModel] {
        return [
            TaskModel(id: 1, title: "Read News", desc: "Reading news is a good habit", date: Date(), isCompleted: false),
            TaskModel(id: 2, title: "Read News-2", desc: "Reading news is a good habit", date: Date(), isCompleted: false),
            TaskModel(id: 3, title: "Read News-3", desc: "Reading news is a good habit", date: Date(), isCompleted: true),
            TaskModel(id: 4, title: "Read News-4", desc: "Reading news is a good habit", date: Date(), isCompleted: false)
        ]
    }
}
