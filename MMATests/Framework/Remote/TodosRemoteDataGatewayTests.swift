//
//  TodosRemoteDataGatewayTests.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/19/23.
//

import XCTest
@testable import MMA

final class TodosRemoteDataGatewayTests: XCTestCase {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: false)
    
    func testTodosRemoteDataGateway_whenResultIsSuccessful_returnsTodos() async {
        let sut = makeSUT()
        let todosResult = await sut.fetchTodos()
        switch todosResult {
        case let .success(todos):
            XCTAssertEqual(todos, [Self.todo])
        case .failure:
            XCTFail("Request should have succeded")
        }
    }

    func testTodosRemoteDataGateway_whenResultIsAFailure_returnsGetTodoError() async {
        let remoteStorageError = GetTodoError.networkError(cause: "network error")
        let todosServiceStub = TodosServiceStub(fetchTodosResult: .failure(remoteStorageError))
        let sut = makeSUT(service: todosServiceStub)
        let todosResult = await sut.fetchTodos()
        switch todosResult {
        case .success:
            XCTFail("Request should have failed")
        case let .failure(error):
            XCTAssertEqual(error, remoteStorageError)
        }
    }

    func testTodosRemoteDataGateway_whenResultIsSuccessful_updatesDbTodos() async {
        let todosDbSpy = TodosDbSpy()
        let sut = makeSUT(db: todosDbSpy)
        let todosResult = await sut.fetchTodos()
        XCTAssertTrue(todosDbSpy.didUpdateTodos)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        service: TodosService = TodosServiceStub(),
        db: TodosDb = TodosDbStub(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> TodosRemoteDataGateway {
        let sut = TodosRemoteDataGateway(service: service, db: db)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    class TodosDbSpy: TodosDbStub {
        var didUpdateTodos = false
        
        override func updateTodos(with todos: [Todo]) async -> Result<Void, UpdateTodoError> {
            didUpdateTodos = true
            return updateTodosResult
        }
    }
}

