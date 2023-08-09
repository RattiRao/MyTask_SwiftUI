//
//  HomeView.swift
//  Task
//
//  Created by Prithvi Rao Ratti on 04/08/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var picketTitles = ["Active", "Completed"]
    @State private var defaultSelectedPicker = "Active"
    @State private var isAddScreenPresented: Bool = false
    @State private var isDetailScreenPresented: Bool = false
    @State private var selectedTask: TaskModel = TaskModel(id: 0, title: "", desc: "", date: Date(), isCompleted: false)
    @State private var refreshTaskList: Bool = false
    
    var body: some View {
        NavigationStack {
            Picker("Picker Filter", selection: $defaultSelectedPicker) {
                ForEach(picketTitles, id: \.self) { title in
                    Text(title)
                }
            }
            .onChange(of: defaultSelectedPicker, perform: { newValue in
                viewModel.getTasks(isCompleted: newValue == "Completed")
            })
            .pickerStyle(.segmented)
            List(viewModel.tasks, id: \.id) { task in
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.title)
                    HStack {
                        Text(task.desc)
                            .font(.subheadline)
                            .lineLimit(2)
                        Spacer()
                        Text(task.date.getFormattedTaskDate())
                            .font(.caption)
                    }
                }
                .onTapGesture {
                    selectedTask = task
                    isDetailScreenPresented = true
                }
            }// List View
            .listStyle(.plain)
            .onChange(of: refreshTaskList, perform: { _ in
                viewModel.getTasks(isCompleted: defaultSelectedPicker == "Completed")
            })
            .onAppear(){
                viewModel.getTasks(isCompleted: false)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddScreenPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }//: Button
                }//: ToolbarItem
            }//: Toolbar
            .sheet(isPresented: $isAddScreenPresented) {
                AddTaskView(viewModel: viewModel, isPresented: $isAddScreenPresented, refreshTaskList: $refreshTaskList)
            }
            
            .sheet(isPresented: $isDetailScreenPresented) {
                TaskDetailView(viewModel: viewModel, taskModel: $selectedTask, isPresented: $isDetailScreenPresented, refreshTaskList: $refreshTaskList)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
