//
//  AddDetailView.swift
//  Task
//
//  Created by Prithvi Rao Ratti on 07/08/23.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var viewModel: TaskViewModel
    @State var taskModel = TaskModel(id: 0, title: "", desc: "", date: Date(), isCompleted: false)
    @Binding var isPresented: Bool
    @Binding var refreshTaskList: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Task Name", text: $taskModel.title)
                    TextEditor(text: $taskModel.desc)
                    
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
            }//: List
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.accentColor)
                    }
                }//: Toolbar Item
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.addTask(task: taskModel)
                        refreshTaskList.toggle()
                        isPresented = false
                    } label: {
                        Text("Add")
                            .foregroundColor(.accentColor)
                    }
                }//: Toolbar Item
            }
        }//: Navigation Stack
    }
}

struct AddDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: TaskViewModel(), isPresented: .constant(true), refreshTaskList: .constant(false))
    }
}
