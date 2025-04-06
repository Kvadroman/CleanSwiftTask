# CleanSwiftTask

CleanSwiftTask is an iOS demo application built using the **Clean Swift (VIP)** architecture and **Dependency Injection** via [Swinject](https://github.com/Swinject/Swinject). The app fetches a list of characters from the [Rick and Morty API](https://rickandmortyapi.com/) and displays detailed information for each character.

## Table of Contents

- [Technologies & Libraries](#technologies--libraries)
- [Project Structure](#project-structure)
- [Installation & Running](#installation--running)
- [Offline Mode](#offline-mode)
- [Screenshots](#screenshots)
- [Contact](#contact)

---

## Technologies & Libraries

- **Swift 5+**
- **iOS 15+**
- **Clean Swift (VIP)** – Separation of layers into Interactor, Presenter, Router, and ViewController.
- **Swinject** – Dependency Injection container.
- **Alamofire** – For network requests (alternatively, you can use `URLSession`).
- **Kingfisher** – For image downloading and caching.
- **SnapKit** – For programmatic Auto Layout.
- **Core Data** – For offline data storage.

---

## Project Structure

```bash
CleanSwiftTask/
├── CleanSwiftTask           # Entry point (AppDelegate/main)
├── Models
│   ├── CharactersResponse.swift
│   └── RMCharacter.swift
├── Scenes
│   ├── DetailScene
│   │   └── DetailViewController.swift
│   └── ListScene
│       ├── Adapter
│       │   ├── CharactersListAdapter.swift
│       │   ├── CharacterCell.swift
│       │   └── ListCellViewModel.swift
│       ├── Interactor
│       │   ├── ListInteractor.swift
│       │   └── PListInteractor.swift
│       ├── Presenter
│       │   ├── ListPresenter.swift
│       │   └── (PListPresenterInput & PListPresenterOutput protocols)
│       ├── Router
│       │   ├── ListRouter.swift
│       │   └── PListRouter.swift
│       └── View
│           └── ListViewController.swift
├── Services
│   ├── NetworkService
│   │   ├── NetworkService.swift
│   │   └── PNetworkService.swift
│   ├── Repository
│   │   ├── ListRepository.swift
│   │   └── PListRepository.swift
│   ├── FileManagerService
│   │   ├── FileManagerService.swift
│   │   └── PFileManagerService.swift
│   ├── CoreDataService   (if separated)
│   └── StorageService
│       ├── StorageService.swift
│       └── PStorageService.swift
├── AppAssembly.swift        # Swinject container and dependency registration
├── AppDelegate.swift        # Entry point (without SceneDelegate)
└── Info.plist
```
Key Components:

- AppAssembly: Contains the DI configuration using Swinject, registering all services, repositories, and VIP components.

- ListScene: Displays the list of characters.

    - ListViewController: Manages the UI for the list.

    - ListInteractor: Handles business logic (fetches data from the repository and calls the Presenter).

    - ListPresenter: Formats raw models into ListCellViewModel and calls viewController?.displayCharacters(...).

    - ListRouter: Handles navigation to the DetailScene.

    - CharactersListAdapter: Adapter using UITableViewDiffableDataSource for managing table view cells.

- DetailScene: Displays character details.

    - DetailViewController: Shows a large image and the character's name.

- Services: Contains various services and repositories:

    - NetworkService: Fetches data from the Rick and Morty API.

    - FileManagerService: Manages local image saving.

    - StorageService: Combines Core Data and FileManagerService for offline storage.

    - ListRepository: Implements data fetching (first tries the network, then falls back to offline storage).

Installation & Running

1. Clone the repository or download the ZIP file.

2. Install Dependencies:

    - Open the project in Xcode.

    - If using Swift Package Manager, dependencies are resolved automatically.

    - If using CocoaPods, run pod install and open the generated .xcworkspace.

3. Build and Run:

    - Open the project in Xcode (version 14+ recommended).

    - Build and run (⌘+R) on a simulator or device.

Minimum iOS Version: iOS 15
Language: Swift 5

Offline Mode

The app supports offline mode by caching data locally:

    - ListRepository first attempts to fetch characters from the network via NetworkService.

    - On success, StorageService saves the results into Core Data (and optionally downloads and saves images locally via FileManagerService).

    - If the network request fails (e.g., no internet connection), ListRepository fetches the latest saved data from Core Data.

    - Thus, users will see the last loaded characters even without an internet connection.
