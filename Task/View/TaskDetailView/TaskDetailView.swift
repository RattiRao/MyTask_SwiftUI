//
//  TaskDetailView.swift
//  Task
//
//  Created by Prithvi Rao Ratti on 07/08/23.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var taskModel: TaskModel
    @Binding var isPresented: Bool
    @Binding var refreshTaskList: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Task Name", text: $taskModel.title)
                    TextEditor(text: $taskModel.desc)
                    Toggle("Mark Complete", isOn: $taskModel.isCompleted)
                    
                } header: {
                    Text("Task Detail")
                }//: Section
                
                Section {
                    DatePicker(selection: $taskModel.date) {
                        Text("Task Date")
                    }
                } header: {
                    Text("Task Date/Time")
                }//: Section
                
                Section {
                    Button {
                        if viewModel.deleteTask(task: taskModel) {
                            refreshTaskList.toggle()
                            isPresented = false
                        }
                    } label: {
                        Text("Delete")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }//: Delete Button
                    
                }
            }//: List
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.accentColor)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if viewModel.updateTask(task: taskModel) {
                            refreshTaskList.toggle()
                            isPresented = false
                        }
                    } label: {
                        Text("Update")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }//: Navigation Stack
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(viewModel: TaskViewModel(), taskModel: .constant(TaskModel.getTasks().first!), isPresented: .constant(true), refreshTaskList: .constant(false))
    }
}
