//
//  PListRepository.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import Foundation

protocol PListRepository {
    func fetchCharacters(completion: @escaping (Result<[RMCharacter], Error>) -> Void)
}
