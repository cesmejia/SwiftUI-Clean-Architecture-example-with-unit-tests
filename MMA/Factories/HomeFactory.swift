//
//  HomeFactory.swift
//  MMA
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import SwiftUI

protocol HomeFactory {
    func makeModule() -> UIViewController
}

struct HomeFactoryImp: HomeFactory {
    @MainActor
    func makeModule() -> UIViewController {
        let todosService = TodosServiceImp()
        let todosDb = TodosDbImp()
        let todosDataSourceRemote = TodosRemoteDataGateway(service: todosService, db: todosDb)
        let todosDataSourceLocal = TodosDbDataGateway(db: todosDb)
        let getTodosSource = GetTodosRepository(todosRemoteSource: todosDataSourceRemote, todosLocalSource: todosDataSourceLocal)
        let getTodosUseCase = GetTodosUseCase(source: getTodosSource)
        let homeViewModel = HomeViewModel(getTodosUseCase: getTodosUseCase)
        return UIHostingController(rootView: HomeView(viewModel: homeViewModel))
    }
}

