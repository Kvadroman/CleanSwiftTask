//
//  ListInteractor.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import Foundation

final class ListInteractor: PListInteractor {
    // MARK: - Properties
    var presenter: PListPresenterInput?
    var repository: PListRepository?
    // MARK: - Interface
    func fetchCharacters() {
        repository?.fetchCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                self.presenter?.presentCharacters(characters)
            case .failure(let error):
                self.presenter?.presentError(error)
            }
        }
    }
}
