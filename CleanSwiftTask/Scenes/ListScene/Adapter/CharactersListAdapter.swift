//
//  CharactersListAdapter.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import UIKit

/// An adapter for displaying a list of Rick & Morty characters using a `UITableViewDiffableDataSource`.
final class CharactersListAdapter: NSObject {
    /// Sections in the table view. Expand them if you need multiple sections.
    private enum Section: CaseIterable {
        case main
    }
    // MARK: - Properties
    /// Called when a user taps a table view cell, passing the selected character view model.
    var onSelectCharacter: ((ListCellViewModel) -> Void)?
    /// Row animation style for updating the table view. Defaults to `.automatic`.
    var defaultRowAnimation: UITableView.RowAnimation = .automatic {
        didSet { dataSource.defaultRowAnimation = defaultRowAnimation }
    }
    private let tableView: UITableView
    private var items: [ListCellViewModel] = []
    /// The diffable data source for managing table view updates.
    private lazy var dataSource: UITableViewDiffableDataSource<Section, ListCellViewModel> = {
        let dataSource = UITableViewDiffableDataSource<Section, ListCellViewModel>(tableView: tableView) { [weak self] tableView, indexPath, character in
            guard let self else { return UITableViewCell() }
            let reuseID = self.cellIdentifier(character)
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
            self.configure(character, cell)
            return cell
        }
        dataSource.defaultRowAnimation = defaultRowAnimation
        tableView.delegate = self
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListCellViewModel>()
        let sections = Section.allCases
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems([], toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
        return dataSource
    }()
    /// A function that returns the reuseIdentifier for each view model, useful if multiple cell types are needed.
    private let cellIdentifier: (ListCellViewModel) -> String
    /// A function that configures each cell with its corresponding `ListCellViewModel`.
    private let configure: (ListCellViewModel, UITableViewCell) -> Void
    // MARK: - Init
    /// Initializes a new instance of `CharactersListAdapter`.
    /// - Parameters:
    ///   - tableView: The `UITableView` to be managed by this adapter.
    ///   - defaultRowAnimation: The row animation to use for diffable updates.
    ///   - registerCells: A closure for registering any custom cell types with the table view.
    ///   - cellIdentifier: A closure that returns the reuseIdentifier for a given `ListCellViewModel`.
    ///   - configure: A closure that configures a cell with the provided `ListCellViewModel`.
    init(
        tableView: UITableView,
        defaultRowAnimation: UITableView.RowAnimation = .automatic,
        registerCells: (UITableView) -> Void,
        cellIdentifier: @escaping (ListCellViewModel) -> String,
        configure: @escaping (ListCellViewModel, UITableViewCell) -> Void
    ) {
        self.tableView = tableView
        self.defaultRowAnimation = defaultRowAnimation
        self.cellIdentifier = cellIdentifier
        self.configure = configure
        super.init()
        registerCells(tableView)
        _ = dataSource
    }
    // MARK: - Interface
    /// Updates the table view with a new list of character view models.
    /// - Parameters:
    ///   - items: The new list of `ListCellViewModel` items.
    ///   - animated: Whether to animate the diffable updates. Default is `false`.
    func update(items: [ListCellViewModel], animated: Bool = false) {
        guard items != self.items else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        let applyChanges = { [weak self] in
            self?.dataSource.apply(snapshot, animatingDifferences: true)
        }
        if animated {
            applyChanges()
        } else {
            UIView.animate(withDuration: 0) { applyChanges() }
        }
        self.items = items
    }
    /// Scrolls the table view to a specific row, if the index is valid.
    /// - Parameters:
    ///   - index: The row index to scroll to.
    ///   - scrollPosition: The position of the row on screen after scrolling.
    ///   - animated: Whether the scrolling should be animated. Defaults to `true`.
    func scrollToRow(at index: Int, scrollPosition: UITableView.ScrollPosition = .top, animated: Bool = true) {
        guard index >= 0, index < items.count else { return }
        let indexPath = IndexPath(row: index, section: 0)
        tableView.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}

extension CharactersListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = items[indexPath.row]
        onSelectCharacter?(character)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
