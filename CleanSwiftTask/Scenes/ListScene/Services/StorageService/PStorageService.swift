//
//  PStorageService.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import Foundation

protocol PStorageService {
    func save(_ characters: [RMCharacter])
    func fetch() -> [RMCharacter]
}
