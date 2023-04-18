//
//  TodosDbImp.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

class TodosDbImp: TodosDb {
    var todos = [Todo]()
    
    func getTodos() async -> Result<[Todo], GetTodoError> {
        .success(todos)
    }
    
    func updateTodos(with todos: [Todo]) async -> Result<Void, UpdateTodoError> {
        self.todos = todos
        return .success(())
    }
}
