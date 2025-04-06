//
//  StorageService.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import CoreData
import Foundation

final class StorageService: PStorageService {
    // MARK: - Properties
    private lazy var context: NSManagedObjectContext = { persistentContainer.viewContext }()
    private let fileManagerService: PFileManagerService
    private let persistentContainer: NSPersistentContainer
    // MARK: - Init
    init(containerName: String, fileManagerService: PFileManagerService) {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                debugPrint("Core Data load error: \(error)")
            }
        }
        self.fileManagerService = fileManagerService
    }
    // MARK: - Interface
    func save(_ characters: [RMCharacter]) {
        context.perform { [weak self] in
            guard let self else { return }
            for char in characters {
                let entity = CharacterEntity(context: context)
                entity.id = Int32(char.id ?? 0)
                entity.name = char.name
                if let imageURLString = char.image,
                   let url = URL(string: imageURLString) {
                    fileManagerService.saveImage(url) {
                        entity.image = $0.absoluteString
                        self.save(entity)
                    }
                } else {
                    entity.image = char.image
                    save(entity)
                }
            }
        }
    }
    func fetch() -> [RMCharacter] {
        let request = NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
        do {
            let results = try context.fetch(request)
            return results.map {
                RMCharacter(
                    id: Int($0.id),
                    name: $0.name,
                    status: nil,
                    species: nil,
                    image: $0.image
                )
            }
        } catch {
            debugPrint("Core Data fetch error: \(error)")
            return []
        }
    }
    // MARK: - Private methods
    private func save(_ entity: CharacterEntity) {
        do {
            try context.save()
        } catch {
            debugPrint("Core Data save error: \(error)")
        }
    }
}
