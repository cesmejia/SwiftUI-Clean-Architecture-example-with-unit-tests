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
    static let todosDataSourceRemoteStub = TodosDataSourceRemoteStub(response: .success([todo]))
    static let todosDataSourceLocalStub = TodosDataSourceLocalStub(response: .success([todo2]))
    static let getTodosSource = buildGetTodosRepository(todosRemoteSource: todosDataSourceRemoteStub, todosLocalSource: todosDataSourceLocalStub)
    static let getTodosUseCase = GetTodosUseCase(source: getTodosSource)
    
    @MainActor
    func testHomeViewModel_whenOnAppear_todosArePopulated() async {
        let sut = makeSUT()
        await sut.onAppearAction()
        XCTAssertFalse(sut.todos.isEmpty)
    }

    @MainActor
    func testHomeViewModel_whenOnAppear_todosArePopulatedWithLocalTodos() async {
        let sut = makeSUT()
        await sut.onAppearAction()
        XCTAssertEqual(sut.todos, [Self.todo2])
    }
    
    @MainActor
    func testHomeViewModel_whenOnAppearGetTodosRemoteFails_errorAlertCauseIsSet() async {
        let remoteErrorCause = "Remote Fetch failed"
        let localErrorCause = "Local Storage failed"
        let getTodoErrorNetworkError = GetTodoError.networkError(cause: remoteErrorCause)
        let todosDataSourceRemoteStubWithError = TodosDataSourceRemoteStub(response: .failure(getTodoErrorNetworkError))
        let todosDataSourceLocalStubWithError = TodosDataSourceLocalStub(response: .failure(.localStorageError(cause: localErrorCause)))
        let getTodosSource = Self.buildGetTodosRepository(todosRemoteSource: todosDataSourceRemoteStubWithError, todosLocalSource: todosDataSourceLocalStubWithError)
        let getTodosUseCase = GetTodosUseCase(source: getTodosSource)
        let sut = makeSUT(getTodosUseCase: getTodosUseCase)
        await sut.onAppearAction()
        XCTAssertEqual(sut.alertError, getTodoErrorNetworkError)
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
    
    private static func buildGetTodosRepository(
        todosRemoteSource: TodosDataSourceRemote = todosDataSourceRemoteStub,
        todosLocalSource: TodosDataSourceLocal = todosDataSourceLocalStub
    ) -> GetTodosRepository {
        return GetTodosRepository(
            todosRemoteSource: todosRemoteSource,
            todosLocalSource: todosLocalSource)
    }
}
