//
//  UpdateTodoError.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import Foundation

enum UpdateTodoError: Error, Equatable, LocalizedError {
    case localStorageError(cause: String)
    
    var errorDescription: String? {
        switch self {
        case .localStorageError(let cause):
            return cause
        }
    }
}
