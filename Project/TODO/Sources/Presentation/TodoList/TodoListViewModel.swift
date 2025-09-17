//
//  TodoListViewModel.swift
//  TODO: app
//
//  Created by Sarvar on 15/09/25.
//

import Combine
import Foundation

protocol TodoListViewModel {
    var items: CurrentValueSubject<[TodoItemViewModel], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }

    func fetchNextPage()
    func search(with: String)
    func selectItem(_ item: TodoItemViewModel)
}

final class TodoListViewModelImpl: TodoListViewModel {
    var items = CurrentValueSubject<[TodoItemViewModel], Never>([])
    var isLoading = CurrentValueSubject<Bool, Never>(false)

    private let coordinator: TodoListCoordinator
    private let fetchTodosWithUsersUseCase: FetchTodosWithUsersUseCase
    private let getTodosWithUsersUseCase: GetTodosWithUsersUseCase

    private var currentOffset = 0
    private let pageSize = 20
    private var allLoaded = false
    private var searchKey: String?
    private var cancellables = Set<AnyCancellable>()


    init(
        getTodosWithUsersUseCase: GetTodosWithUsersUseCase,
        fetchTodosWithUsersUseCase: FetchTodosWithUsersUseCase,
        coordinator: TodoListCoordinator
    ) {
        self.getTodosWithUsersUseCase = getTodosWithUsersUseCase
        self.fetchTodosWithUsersUseCase = fetchTodosWithUsersUseCase
        self.coordinator = coordinator

        fetchTodosWithUserList()
    }
    
    private func fetchTodosWithUserList() {
        Task { @MainActor in
            
            fetchNextPage()
            isLoading.send(items.value.isEmpty)

            Task.detached { [weak self] in
                guard let self else { return }
                do {
                    _ = try await self.fetchTodosWithUsersUseCase.execute()
                    await MainActor.run {
                        self.currentOffset = 0
                        self.allLoaded = false
                        self.items.send([])
                        self.fetchNextPage()
                    }
                } catch {
                    print("Network fetch failed: \(error.localizedDescription)")
                }
            }

            isLoading.send(false)
        }
    }

    func fetchNextPage() {
        guard !allLoaded else { return }
        Task { @MainActor in
            do {
                let models = try await getTodosWithUsersUseCase.execute(offset: currentOffset, limit: pageSize, key: searchKey)
                let viewModels = models.compactMap { TodoItemViewModelMapper().map($0) }
                items.send(items.value + viewModels)
                currentOffset += viewModels.count
                allLoaded = viewModels.count < pageSize
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func search(with key: String) {
        searchKey = key
        currentOffset = 0
        allLoaded = false
        items.send([])
        fetchNextPage()
    }

    func selectItem(_ item: TodoItemViewModel) {
        coordinator.showDetails(item)
    }
}
