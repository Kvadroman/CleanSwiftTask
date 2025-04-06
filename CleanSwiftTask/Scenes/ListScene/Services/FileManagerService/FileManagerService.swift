//
//  FileManagerService.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import Kingfisher
import UIKit

final class FileManagerService: PFileManagerService {
    // MARK: - Interface
    func saveImage(_ url: URL, completion: ((URL) -> Void)?) {
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                let image = value.image
                let filename = UUID().uuidString + ".jpg"
                if let localURL = self?.saveImage(image, withName: filename) {
                    completion?(localURL)
                } else {
                    completion?(url) // fallback
                }
            case .failure(let error):
                debugPrint("Kingfisher error: \(error)")
                completion?(url)
            }
        }
    }
    private func saveImage(_ image: UIImage, withName name: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.8),
              let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let fileURL = cachesDirectory.appendingPathComponent(name)
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            debugPrint("Error saving image: \(error)")
            return nil
        }
    }
}
