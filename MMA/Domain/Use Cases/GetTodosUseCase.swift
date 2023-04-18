//
//  GetTodosUseCase.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/17/23.
//

class GetTodosUseCase {
    let source: GetTodosSource
    
    init(source: GetTodosSource) {
        self.source = source
    }
    
    func getTodos() async -> Result<[Todo], GetTodoError> {
        await source.getTodos()
    }
}
