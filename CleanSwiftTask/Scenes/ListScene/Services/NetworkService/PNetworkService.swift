//
//  PNetworkService.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import Foundation

protocol PNetworkService {
    func fetchCharacters(completion: @escaping (Result<[RMCharacter], Error>) -> Void)
}
