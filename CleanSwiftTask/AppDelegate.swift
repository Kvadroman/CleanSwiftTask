//
//  AppDelegate.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 05.04.2025.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let assembly = AppAssembly()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let listVC = assembly.container.resolve(ListViewController.self)!
        let navController = UINavigationController(rootViewController: listVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}

