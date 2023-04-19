//
//  TodosDb.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

protocol TodosDb {
    func getTodos() async -> Result<[Todo], GetTodoError>
    func updateTodos(with todos: [Todo]) async -> Result<Void, UpdateTodoError>
}

class TodosDbStub: TodosDb {
    let getTodosResult: Result<[Todo], GetTodoError>
    let updateTodosResult: Result<Void, UpdateTodoError>
    
    init(
        getTodosResult: Result<[Todo], GetTodoError> = .success([Todo(userId: 1, id: 1, title: "title", completed: false)]),
        updateTodosResult: Result<Void, UpdateTodoError> = .success(())
    ) {
        self.getTodosResult = getTodosResult
        self.updateTodosResult = updateTodosResult
    }
    
    func getTodos() async -> Result<[Todo], GetTodoError> {
        getTodosResult
    }
    
    func updateTodos(with todos: [Todo]) async -> Result<Void, UpdateTodoError> {
        updateTodosResult
    }
}
