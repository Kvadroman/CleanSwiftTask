//
//  PListPresenterInput.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import Foundation

protocol PListPresenterInput: AnyObject {
    func presentCharacters(_ characters: [RMCharacter])
    func presentError(_ error: Error)
}
