//
//  AppDelegate.swift
//  PMM
//
//  Created by Aleksandr Gabrielyan on 18.12.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
			let window = UIWindow(frame: UIScreen.main.bounds)
			let applicationCoordinator = ApplicationCoordinator(window: window) // 2

			self.window = window
			self.applicationCoordinator = applicationCoordinator

			applicationCoordinator.start()
        return true
    }


}

