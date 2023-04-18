//
//  GetTodosUseCaseTests.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/17/23.
//

import XCTest
@testable import MMA

final class GetTodosUseCaseTests: XCTestCase {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: true)
    
    func testGetTodosUseCase_whenCallingGetTodosIsSuccessful_getsSuccessfulResponse() async {
        let sut = makeSUT()
        let getTodoResult = await sut.getTodos()
        XCTAssertEqual(Result.success([Self.todo]), getTodoResult)
    }

    func testGetTodosUseCase_whenCallingGetTodosFails_getsErrorResponse() async {
        let getTodosSource = GetTodosSourceStub(response: .failure(.networkError(cause: "cause")))
        let sut = makeSUT(getTodosSource: getTodosSource)
        let getTodoResult = await sut.getTodos()
        XCTAssertEqual(Result.failure(.networkError(cause: "cause")), getTodoResult)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        getTodosSource: GetTodosSource = GetTodosSourceStub(response: .success([todo])),
        file: StaticString = #file,
        line: UInt = #line
    ) -> GetTodosUseCase {
        let sut = GetTodosUseCase(
            source: getTodosSource
        )
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
