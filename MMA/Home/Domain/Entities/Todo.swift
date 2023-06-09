//
//  Todo.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/17/23.
//

struct Todo: Identifiable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

extension Todo: Codable {}
