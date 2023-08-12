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
    @State var isCancelAlertPresented: Bool = false
    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let currentDateComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
        
        let startDateComponent = DateComponents(year: currentDateComponent.year, month: currentDateComponent.month, day: currentDateComponent.day, hour: currentDateComponent.hour, minute: currentDateComponent.minute)
        
        let endDateComponent = DateComponents(year: 2024, month: 12, day: 31)
        
        return calendar.date(from: startDateComponent)! ... calendar.date(from: endDateComponent)!
    }
    
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
                    DatePicker(selection: $taskModel.date, in: dateRange) {
                        Text("Task Date")
                    }
                } header: {
                    Text("Task Date/Time")
                }//: Section
            }//: List
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if !taskModel.title.isEmpty {
                            isCancelAlertPresented = true
                        }
                        else {
                            isCancelAlertPresented = false
                            isPresented = false
                        }
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.accentColor)
                    }.alert("Save Task", isPresented: $isCancelAlertPresented) {
                        Button {
                            addTask()
                        } label: {
                            Text("Yes")
                        }//: Button
                        
                        Button(role: .destructive){
                            isPresented = false
                        } label: {
                            Text("No")
                        }//: Button

                    } message: {
                        Text("Do you want to save task?")
                    }

                }//: Toolbar Item
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addTask()
                    } label: {
                        Text("Add")
                            .foregroundColor(.accentColor)
                    }.disabled(taskModel.title.isEmpty)
                }//: Toolbar Item
            }
        }//: Navigation Stack
    }
    
    func addTask() {
        viewModel.addTask(task: taskModel)
        refreshTaskList.toggle()
        isPresented = false
    }
}

struct AddDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: TaskViewModel(), isPresented: .constant(true), refreshTaskList: .constant(false))
    }
}
