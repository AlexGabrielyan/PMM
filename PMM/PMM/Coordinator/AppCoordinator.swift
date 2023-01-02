//
//  AppCoordinator.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/28/22.
//

import UIKit

class ApplicationCoordinator: Coordinator {

	let window: UIWindow
	let rootViewController: UINavigationController
	let mainCoordinator: MainViewCoordinator

	init(window: UIWindow) {
		self.window = window
		rootViewController = UINavigationController()
		rootViewController.navigationBar.prefersLargeTitles = true

		mainCoordinator = MainViewCoordinator(presenter: rootViewController)
	}

	func start() {
		window.rootViewController = rootViewController
		mainCoordinator.start()
		if BudgetService().getBudget() == nil {
			mainCoordinator.goToEditDailyLimit()
		}
		window.makeKeyAndVisible()
	}

	func back() {
		rootViewController.popViewController(animated: true)
	}
}
