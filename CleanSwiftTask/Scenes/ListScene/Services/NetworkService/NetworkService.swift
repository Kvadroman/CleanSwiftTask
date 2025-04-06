//
//  NetworkService.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import Alamofire
import Foundation

final class NetworkService: PNetworkService {
    // MARK: - Interface
    func fetchCharacters(completion: @escaping (Result<[RMCharacter], Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        AF.request(urlString)
            .validate()
            .responseDecodable(of: CharactersResponse.self) {
                switch $0.result {
                case .success(let decoded):
                    completion(.success(decoded.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
