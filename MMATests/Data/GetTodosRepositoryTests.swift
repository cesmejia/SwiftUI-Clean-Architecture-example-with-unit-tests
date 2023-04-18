//
//  GetTodosRepositoryTests.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import XCTest
@testable import MMA

final class GetTodosRepositoryTests: XCTestCase {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: true)
    static let todo2 = Todo(userId: 2, id: 2, title: "title", completed: true)
    
    func testGetTodosRepository_whenGettingTodosFromLocalSourceSuccessfuly_returnsTodos() async {
        let sut = makeSUT()
        let getTodoResult = await sut.getTodos()
        XCTAssertEqual(Result.success([Self.todo]), getTodoResult)
    }

    func testGetTodosRepository_whenGettingTodosFromLocalSourceIsEmpty_returnsRemoteTodos() async {
        let sut = makeSUT(todosLocalSource: TodosDataSourceLocalStub(response: .success([])))
        let getTodoResult = await sut.getTodos()
        XCTAssertEqual(Result.success([Self.todo2]), getTodoResult)
    }

    func testGetTodosRepository_whenGettingTodosFromLocalSourceFails_returnsRemoteTodos() async {
        let sut = makeSUT(todosLocalSource: TodosDataSourceLocalStub(response: .failure(.localStorageError(cause: "localError"))))
        let getTodoResult = await sut.getTodos()
        XCTAssertEqual(Result.success([Self.todo2]), getTodoResult)
    }

    func testGetTodosRepository_whenGettingTodosFromBothSourcesFail_returnsNetworkError() async {
        let sut = makeSUT(
            todosRemoteSource: TodosDataSourceRemoteStub(response: .failure(.networkError(cause: "remoteError"))),
            todosLocalSource: TodosDataSourceLocalStub(response: .failure(.localStorageError(cause: "localError")))
        )
        let getTodoResult = await sut.getTodos()
        XCTAssertEqual(Result.failure(GetTodoError.networkError(cause: "remoteError")), getTodoResult)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        todosRemoteSource: TodosDataSourceRemote = TodosDataSourceRemoteStub(response: .success([todo2])),
        todosLocalSource: TodosDataSourceLocal = TodosDataSourceLocalStub(response: .success([todo])),
        file: StaticString = #file,
        line: UInt = #line
    ) -> GetTodosRepository {
        let sut = GetTodosRepository(
            todosRemoteSource: todosRemoteSource,
            todosLocalSource: todosLocalSource)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

