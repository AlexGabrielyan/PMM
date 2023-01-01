//
//  SpendingsCoordinator.swift
//  PMM
//
//  Created by Vahan Grigoryan on 1/1/23.
//

import UIKit

class SpendingsCoordinator: Coordinator {
	private let presenter: UINavigationController
	private var spendingsViewController: SpendingsViewController?

	var spendingCoordinator: SpendingCoordinator?
	
	init(presenter: UINavigationController) {
		self.presenter = presenter
	}

	func start() {
		let spendingsVC = SpendingsViewController()
		spendingsVC.delegate = self
		spendingsVC.title = "Spendings"
		let transactionService = TransactionService()
		spendingsVC.viewModel = SpendingsViewModel(transaction: transactionService)

		presenter.pushViewController(spendingsVC, animated: true)
		self.spendingsViewController = spendingsVC
	}
}

extension SpendingsCoordinator: SpendingsViewControllerDelegate {
	func goToSpending(spending: Spending) {
		spendingCoordinator = SpendingCoordinator(presenter: self.presenter)
		spendingCoordinator?.spending = spending
		spendingCoordinator?.start()
	}

	func goToAddSpending() {
		spendingCoordinator = SpendingCoordinator(presenter: self.presenter)
		spendingCoordinator?.start()
	}
	
	func back() {
		presenter.popViewController(animated: true)
	}
}
