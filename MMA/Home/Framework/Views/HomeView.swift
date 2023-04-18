//
//  HomeView.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.todos) { todo in
                HStack {
                    Text(todo.title)
                    Spacer()
                    Image(systemName: todo.completed ? "checkmark.circle.fill" : "x.circle.fill")
                        .foregroundColor(todo.completed ? .green : .pink)
                }
                .listRowBackground(Color.blue.opacity(0.5))
            }
        }
        .background(.cyan.gradient)
        .toolbarBackground(.cyan.gradient, for: .navigationBar)
        .scrollContentBackground(.hidden)
        .navigationTitle("Todos")
        .onAppear {
            Task {
                await viewModel.onAppearAction()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: true)
    static let todo2 = Todo(userId: 2, id: 2, title: "title 2", completed: false)
    static let getTodosSource = GetTodosSourceStub(response: .success([todo, todo2]))
    static let getTodosUseCase = GetTodosUseCase(source: getTodosSource)
    static let homeViewModel = HomeViewModel(getTodosUseCase: getTodosUseCase)
    
    static var previews: some View {
        NavigationStack {
            HomeView(viewModel: homeViewModel)
        }
    }
}
