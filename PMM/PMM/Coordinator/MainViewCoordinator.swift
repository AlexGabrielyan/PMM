//
//  MainViewCoordinator.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/28/22.
//

import UIKit

class MainViewCoordinator: Coordinator {
	private let presenter: UINavigationController
	private var spendingCoordinator: SpendingCoordinator?
	private var dailyCoordinator: DailyLimitCoordinator?
	private var spendingListCoordinator: SpendingsCoordinator?

	init(presenter: UINavigationController) {
		self.presenter = presenter
	}

	func start() {
		let viewController = MainViewController.init(nibName: "MainViewController", bundle: nil)
		viewController.delegate = self
		let transactionService = TransactionService()
		let budgetService = BudgetService()
		viewController.viewModel = MainViewModel(transactionService: transactionService,
																						 budgetService: budgetService)
		presenter.pushViewController(viewController, animated: true)

		self.dailyCoordinator = DailyLimitCoordinator(presenter: self.presenter)
		self.spendingCoordinator = SpendingCoordinator(presenter: self.presenter)
	}
}

extension MainViewCoordinator: MainViewControllerDelegate {
	func goToSpendingList() {
		spendingListCoordinator = SpendingsCoordinator(presenter: self.presenter)
		spendingListCoordinator?.start()
	}
	
	func goToEditDailyLimit() {
		dailyCoordinator?.start()
	}

	func goToAddSpending() {
		spendingCoordinator?.start()
	}

	func goToSpending(spending: Spending) {
		spendingCoordinator?.spending = spending
		spendingCoordinator?.start()
	}

	func back() {
		presenter.popViewController(animated: true)
	}
}
