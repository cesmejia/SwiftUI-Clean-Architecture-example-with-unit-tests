//
//  HomeViewModel.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var todos = [Todo]()
    @Published var alertError: GetTodoError?
    
    let getTodosUseCase: GetTodosUseCase

    init(getTodosUseCase: GetTodosUseCase) {
        self.getTodosUseCase = getTodosUseCase
    }
    
    private func getTodos() async {
        let todosResult = await getTodosUseCase.getTodos()
        switch todosResult {
        case let .success(todos):
            self.todos = todos
        case let .failure(getTodoError):
            alertError = getTodoError
        }
    }

    func onAppearAction() async {
        await getTodos()
    }
    
    func refreshListAction() async {
        await getTodos()
    }
}
