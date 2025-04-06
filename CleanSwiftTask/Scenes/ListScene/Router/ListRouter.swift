//
//  ListRouter.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import UIKit

final class ListRouter: PListRouter {
    weak var viewController: UIViewController?
    
    func routeToDetail(with model: ListCellViewModel) {
        let detailVC = DetailViewController()
        detailVC.characterVM = model
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
