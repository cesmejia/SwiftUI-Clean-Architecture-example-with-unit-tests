//
//  TodosServiceImp.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

class TodosServiceImp: TodosService {
    func fetchTodos() async -> Result<[Todo], GetTodoError> {
        let urlSession = URLSession.shared
        let uRLRequest = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos")!)
        do {
            let (data, urlResponse) = try await urlSession.data(for: uRLRequest)
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                return .failure(.networkError(cause: "HTTPURLResponse cast error"))
            }
            guard urlResponse.statusCode == 200 else {
                return .failure(.networkError(cause: "HTTPURLResponse statusCode was not 200"))
            }
            let todos = try JSONDecoder().decode([Todo].self, from: data)
            return .success(todos)
        } catch {
            return .failure(.networkError(cause: error.localizedDescription))
        }
    }

    // More todos requests here...
}
