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
