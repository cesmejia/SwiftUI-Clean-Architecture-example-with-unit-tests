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
