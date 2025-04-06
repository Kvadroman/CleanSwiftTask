//
//  ListViewController.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import SnapKit
import UIKit

final class ListViewController: UIViewController {
    // MARK: - VIP references
    var interactor: PListInteractor?
    var router: PListRouter?
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    // MARK: - Adapter
    private lazy var adapter = CharactersListAdapter(
        tableView: tableView,
        defaultRowAnimation: .automatic,
        registerCells: { tableView in
            tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseId)
        },
        cellIdentifier: { _ in
            CharacterCell.reuseId
        },
        configure: { model, cell in
            guard let characterCell = cell as? CharacterCell else { return }
            characterCell.configure(with: model)
        }
    )
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupConstraints()
        setupVIP()
    }
    private func configureViews() {
        title = "Character List"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func setupVIP() {
        adapter.onSelectCharacter = { [weak self] in
            self?.router?.routeToDetail(with: $0)
        }
        interactor?.fetchCharacters()
    }
}

// MARK: - PListDisplayLogic
extension ListViewController: PListPresenterOutput {
    func displayCharacters(viewModel viewModels: [ListCellViewModel]) {
        adapter.update(items: viewModels, animated: true)
    }
    func displayError(message: String) {
        debugPrint("Error:", message)
    }
}

