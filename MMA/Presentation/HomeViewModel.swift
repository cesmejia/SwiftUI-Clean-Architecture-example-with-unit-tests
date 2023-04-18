//
//  HomeViewModel.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var todos = [Todo]()
    @Published var errorAlertCause: String?
    
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
            errorAlertCause = extractErrorCause(getTodoError: getTodoError)
        }
    }
    
    private func extractErrorCause(getTodoError: GetTodoError) -> String {
        switch getTodoError {
        case .networkError(let cause):
            return cause
        case .localStorageError(let cause):
            return cause
        }
    }
}
