//
//  GetTodosSource.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/17/23.
//

import Foundation

protocol GetTodosSource {
    func getTodos() async -> Result<[Todo], GetTodoError>
}

class GetTodosSourceStub: GetTodosSource {
    let response: Result<[Todo], GetTodoError>

    init(response: Result<[Todo], GetTodoError>) {
        self.response = response
    }
    
    func getTodos() -> Result<[Todo], GetTodoError> {
        response
    }
}
