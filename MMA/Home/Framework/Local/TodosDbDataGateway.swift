//
//  TodosDbDataGateway.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

class TodosDbDataGateway: TodosDataSourceLocal {
    let db: TodosDb
    
    init(db: TodosDb) {
        self.db = db
    }
    
    func fetchTodos() async -> Result<[Todo], GetTodoError> {
        await db.getTodos()
    }
}
