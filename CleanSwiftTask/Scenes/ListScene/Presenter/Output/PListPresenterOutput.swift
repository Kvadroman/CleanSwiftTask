//
//  PListPresenterOutput.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import Foundation

protocol PListPresenterOutput: AnyObject {
    func displayCharacters(viewModel: [ListCellViewModel])
    func displayError(message: String)
}
