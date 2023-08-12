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
    @State private var isDeleteAlert: Bool = false
    
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
                    Button(role: .destructive) {
                        isDeleteAlert.toggle()
                    } label: {
                        Text("Delete")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }//: Delete Button
                    .alert("Delete Task", isPresented: $isDeleteAlert) {
                        Button {
                            if viewModel.deleteTask(task: taskModel) {
                                refreshTaskList.toggle()
                                isPresented = false
                            }
                        } label: {
                            Text("Yes")
                        }//: Yes Button
                        
                        Button {
                            //Do nothing
                        } label: {
                            Text("No")
                        }//: No Button

                    } message: {
                        Text("Do you want to delete task?")
                    }//: Alert
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
                    .disabled(taskModel.title.isEmpty)
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
