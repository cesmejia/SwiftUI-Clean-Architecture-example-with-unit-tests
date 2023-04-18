//
//  TodosRemoteDataGateway.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

class TodosRemoteDataGateway: TodosDataSourceRemote {
    let service: TodosService
    let db: TodosDb
    
    init(service: TodosService, db: TodosDb) {
        self.service = service
        self.db = db
    }
    
    func fetchTodos() async -> Result<[Todo], GetTodoError> {
        let fetchTodosResponse = await service.fetchTodos()
        switch fetchTodosResponse {
        case let .success(todos):
            let _ = await db.updateTodos(with: todos)
            return .success(todos)
        case let .failure(error):
            return .failure(error)
        }
    }
}
