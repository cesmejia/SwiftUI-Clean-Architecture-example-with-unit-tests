//
//  GetTodoError.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/17/23.
//

import Foundation

enum GetTodoError: Error, Hashable, Identifiable, Equatable, LocalizedError {
    var id: Self { self }
    
    case networkError(cause: String)
    case localStorageError(cause: String)
    
    var errorDescription: String? {
        switch self {
        case .networkError(let cause):
            return cause
        case .localStorageError(let cause):
            return cause
        }
    }
}
