//
//  TodosServiceImpTests.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import XCTest
@testable import MMA

final class TodosServiceImpTests: XCTestCase {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: true)
    static let todo2 = Todo(userId: 2, id: 2, title: "title", completed: true)
    
    override func tearDown() {
        super.tearDown()
        
        URLProtocolStub.removeStub()
    }
    
    func testTodosServiceImp_whenFetchingTodosRequestSucceeds_returnsTodos() async {
        let url = URL(string: "https://jsonplaceholder.typicode.com")!
        
        let todoList = [Self.todo, Self.todo2]
        let encodedTodoList = try? JSONEncoder().encode(todoList.self)
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        URLProtocolStub.stub(data: encodedTodoList, response: urlResponse, error: nil)
        
        let sut = makeSUT()
        let todosResult = await sut.fetchTodos()
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
    ) -> TodosServiceImp {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let urlSession = URLSession(configuration: configuration)
        
        let sut = TodosServiceImp(urlSession: urlSession)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
