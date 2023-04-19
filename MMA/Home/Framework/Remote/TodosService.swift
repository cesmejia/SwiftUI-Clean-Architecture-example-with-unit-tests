//
//  TodosService.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

protocol TodosService {
    func fetchTodos() async -> Result<[Todo], GetTodoError>
    // More todos requests here...
}

class TodosServiceStub: TodosService {
    let fetchTodosResult: Result<[Todo], GetTodoError>
    
    init(
        fetchTodosResult: Result<[Todo], GetTodoError> = .success([Todo(userId: 1, id: 1, title: "title", completed: false)])
    ) {
        self.fetchTodosResult = fetchTodosResult
    }
    
    func fetchTodos() async -> Result<[Todo], GetTodoError> {
        fetchTodosResult
    }
}
