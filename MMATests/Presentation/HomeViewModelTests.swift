//
//  HomeViewModelTests.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import XCTest
@testable import MMA

final class HomeViewModelTests: XCTestCase {
    
    static let todo = Todo(userId: 1, id: 1, title: "title", completed: true)
    static let todo2 = Todo(userId: 2, id: 2, title: "title", completed: true)
    static let todosDataSourceRemote = TodosDataSourceRemoteStub(response: .success([todo]))
    static let todosDataSourceLocal = TodosDataSourceLocalStub(response: .success([todo2]))
    static let getTodosSource = GetTodosRepository(todosRemoteSource: todosDataSourceRemote, todosLocalSource: todosDataSourceLocal)
    static let getTodosUseCase = GetTodosUseCase(source: getTodosSource)
    
    @MainActor
    func testHomeViewModel_whenOnAppear_todosArePopulated() async {
        let sut = makeSUT()
        await sut.onAppearAction()
        XCTAssertFalse(sut.todos.isEmpty)
    }
    
    // MARK: - Helpers
    
    @MainActor
    private func makeSUT(
        getTodosUseCase: GetTodosUseCase = getTodosUseCase,
        file: StaticString = #file,
        line: UInt = #line
    ) -> HomeViewModel {
        let sut = HomeViewModel(getTodosUseCase: getTodosUseCase)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
