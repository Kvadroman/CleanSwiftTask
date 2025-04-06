//
//  ListPresenter.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import Foundation

final class ListPresenter: PListPresenterInput {
    // MARK: - Properties
    weak var viewController: PListPresenterOutput?
    // MARK: - Interface
    func presentCharacters(_ characters: [RMCharacter]) {
        let vm = characters
            .map {
            ListCellViewModel(
                id: $0.id ?? 0,
                name: $0.name ?? "",
                imageURL: $0.image ?? .init()
            )
        }
        viewController?.displayCharacters(viewModel: vm)
    }
    func presentError(_ error: Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
}

