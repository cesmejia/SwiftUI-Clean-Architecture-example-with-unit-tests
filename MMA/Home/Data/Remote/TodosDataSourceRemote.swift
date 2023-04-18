//
//  TodosDataSourceRemote.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

protocol TodosDataSourceRemote {
    func fetchTodos() async -> Result<[Todo], GetTodoError>
}

class TodosDataSourceRemoteStub: TodosDataSourceRemote {
    let response: Result<[Todo], GetTodoError>

    init(response: Result<[Todo], GetTodoError>) {
        self.response = response
    }
    
    func fetchTodos() -> Result<[Todo], GetTodoError> {
        response
    }
}
