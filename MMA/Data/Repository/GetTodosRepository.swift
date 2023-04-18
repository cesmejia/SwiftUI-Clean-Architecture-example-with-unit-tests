//
//  GetTodosRepository.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

class GetTodosRepository: GetTodosSource {
    let todosRemoteSource: TodosDataSourceRemote
    let todosLocalSource: TodosDataSourceLocal
    
    init(todosRemoteSource: TodosDataSourceRemote, todosLocalSource: TodosDataSourceLocal) {
        self.todosRemoteSource = todosRemoteSource
        self.todosLocalSource = todosLocalSource
    }
    
    func getTodos() async -> Result<[Todo], GetTodoError> {
        let todosLocalSourceResponse = await todosLocalSource.fetchTodos()
        switch todosLocalSourceResponse {
        case let .success(todos):
            if todos.isEmpty {
                return await todosRemoteSource.fetchTodos()
            }
            return todosLocalSourceResponse
        case .failure:
            return todosLocalSourceResponse
        }
    }
}
