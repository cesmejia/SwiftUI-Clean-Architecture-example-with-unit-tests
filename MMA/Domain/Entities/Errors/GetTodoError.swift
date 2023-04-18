//
//  GetTodoError.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/17/23.
//

enum GetTodoError: Error, Equatable {
    case networkError(cause: String)
}
