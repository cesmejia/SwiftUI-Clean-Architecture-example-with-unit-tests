//
//  GetTodosSource.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/17/23.
//

import Foundation

protocol GetTodosSource {
    func getTodos() -> Result<Todo, GetTodoError>
}
