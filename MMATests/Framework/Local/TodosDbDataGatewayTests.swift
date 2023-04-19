//
//  TodosDbDataGatewayTests.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/19/23.
//

import XCTest
@testable import MMA

final class TodosDbDataGatewayTests: XCTestCase {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: false)
    
    func testTodosDbDataGateway_whenResultIsSuccessful_returnsTodos() async {
        let sut = makeSUT()
        let todosResult = await sut.fetchTodos()
        switch todosResult {
        case let .success(todos):
            XCTAssertEqual(todos, [Self.todo])
        case .failure:
            XCTFail("Request should have succeded")
        }
    }

    func testTodosDbDataGateway_whenResultIsAFailure_returnsGetTodoError() async {
        let localStorageError = GetTodoError.localStorageError(cause: "local storage error")
        let todosDbStub = TodosDbStub(getTodosResult: .failure(localStorageError))
        let sut = makeSUT(db: todosDbStub)
        let todosResult = await sut.fetchTodos()
        switch todosResult {
        case .success:
            XCTFail("Request should have failed")
        case let .failure(error):
            XCTAssertEqual(error, localStorageError)
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        db: TodosDb = TodosDbStub(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> TodosDbDataGateway {
        let sut = TodosDbDataGateway(db: db)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
