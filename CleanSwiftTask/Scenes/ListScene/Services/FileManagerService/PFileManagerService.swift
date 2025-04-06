//
//  PFileManagerService.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 06.04.2025.
//

import UIKit

protocol PFileManagerService {
    /// Saves the provided image with the given name in the caches directory.
    /// Returns the local file URL if successful.
    func saveImage(_ url: URL, completion: ((URL) -> Void)?)
}
