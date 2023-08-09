//
//  TaskViewModel.swift
//  Task
//
//  Created by Prithvi Rao Ratti on 04/08/23.
//

import Foundation

final class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    private var tempTasks: [TaskModel] = TaskModel.getTasks()
    
    func getTasks(isCompleted: Bool) {
        tasks = tempTasks.filter({$0.isCompleted == isCompleted})
    }
    
    func addTask(task: TaskModel) {
        let randomId = Int.random(in: 5 ... 100)
        let newTask = TaskModel(id: randomId,
                                title: task.title,
                                desc: task.desc,
                                date: task.date, isCompleted: task.isCompleted)
        tempTasks.append(newTask)
    }
    
    func updateTask(task: TaskModel) -> Bool {
        if let index = tempTasks.firstIndex(where: {$0.id == task.id}) {
            var updateTask = tempTasks[index]
            
            updateTask.title = task.title
            updateTask.desc = task.desc
            updateTask.isCompleted = task.isCompleted
            updateTask.date = task.date
            
            tempTasks[index] = updateTask
            
            return true
        }
        return false
    }
    
    func deleteTask(task: TaskModel) -> Bool {
        if let index = tempTasks.firstIndex(where: {$0.id == task.id}) {
            tempTasks.remove(at: index)
            return true
        }
        return false
    }
}
