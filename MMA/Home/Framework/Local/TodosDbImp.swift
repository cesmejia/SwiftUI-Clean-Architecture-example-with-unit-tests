//
//  TodosDbImp.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

class TodosDbImp: TodosDb {
    func getTodos() async -> Result<[Todo], GetTodoError> {
        do {
            let todos = try await loadTodos()
            return .success(todos)
        } catch {
            return .failure(.localStorageError(cause: error.localizedDescription))
        }
    }
    
    func updateTodos(with todos: [Todo]) async -> Result<Void, UpdateTodoError> {
        do {
            try await save(todos: todos)
            return .success(())
        } catch {
            return .failure(.localStorageError(cause: error.localizedDescription))
        }
    }
    
    // MARK: - FileManager
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("todos.data")
    }
    
    private func loadTodos() async throws -> [Todo] {
        let task = Task<[Todo], Error> {
            let fileURL = try fileURL()
            guard let data = try? Data(contentsOf: fileURL) else { return [] }
            let todos = try JSONDecoder().decode([Todo].self, from: data)
            return todos
        }
        return try await task.value
    }
    
    func save(todos: [Todo]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(todos)
            let outfile = try fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
