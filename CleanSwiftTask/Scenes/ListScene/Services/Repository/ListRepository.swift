//
//  ListRepository.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import Foundation

final class ListRepository: PListRepository {
    // MARK: - Properties
    let networkService: PNetworkService
    let storageService: PStorageService
    // MARK: - Init
    init(networkService: PNetworkService, storageService: PStorageService) {
        self.networkService = networkService
        self.storageService = storageService
    }
    // MARK: - Interface
    func fetchCharacters(completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        networkService.fetchCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let chars):
                storageService.save(chars)
                completion(.success(chars))
            case .failure(let error):
                let localChars = storageService.fetch()
                if !localChars.isEmpty {
                    completion(.success(localChars))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}

