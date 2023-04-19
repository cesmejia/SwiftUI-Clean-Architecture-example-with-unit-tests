//
//  TodosDbImpTests.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import XCTest
@testable import MMA

final class TodosDbImpTests: XCTestCase {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: true)
    static let todo2 = Todo(userId: 2, id: 2, title: "title", completed: true)
    
    static let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    override func tearDownWithError() throws {
        super.tearDown()
        try FileManager.default.removeItem(at: Self.temporaryDirectoryURL)
    }
    
    func testTodosDbImp_whenRequestingGetTodosInitially_getsAnEmptyTodoList() async {
        let sut = makeSUT()
        let todosResult = await sut.getTodos()
        
        switch todosResult {
        case let .success(todos):
            XCTAssertEqual(todos, [])
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    func testTodosDbImp_whenUpdatingTodos_todosAreSavedInADirectory() async {
        let todoList = [Self.todo, Self.todo2]
        let sut = makeSUT()
        _ = await sut.updateTodos(with: todoList)
        let todosResult = await sut.getTodos()
        
        switch todosResult {
        case let .success(todos):
            XCTAssertEqual(todos, todoList)
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> TodosDbImp {
        let sut = TodosDbImp(directoryURL: Self.temporaryDirectoryURL)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
