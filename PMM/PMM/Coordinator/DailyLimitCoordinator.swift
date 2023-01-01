//
//  DailyLimitCoordinator.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/29/22.
//

import UIKit

class DailyLimitCoordinator: Coordinator {
	private let presenter: UINavigationController
	private var spendingCoordinator: SpendingCoordinator?

	init(presenter: UINavigationController) {
		self.presenter = presenter
	}

	func start() {
		let dailyLimitVC = DailyLimitViewController()
		dailyLimitVC.delegate = self
		dailyLimitVC.title = "Budget"
		let service = BudgetService()
		dailyLimitVC.viewModel = DailyLimitsViewModel(budgetSercice: service)

		presenter.pushViewController(dailyLimitVC, animated: true)
		self.spendingCoordinator = SpendingCoordinator(presenter: self.presenter, expenseType: .monthly)
	}
}

extension DailyLimitCoordinator: DailyLimitViewControllerDelegate {
	func goToSpending(spending: Spending?) {
		spendingCoordinator?.start()
	}

	func goToAddSpending() {
		spendingCoordinator?.start()
	}

	func back() {
		presenter.popViewController(animated: true)
	}
}
