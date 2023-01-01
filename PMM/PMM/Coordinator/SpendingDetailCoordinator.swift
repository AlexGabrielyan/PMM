//
//  ExpenseDetailsCoordinator.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/28/22.
//

import UIKit

class SpendingCoordinator: Coordinator {
	private let presenter: UINavigationController
	private var spendingViewController: SpendingViewController?
	var spending: Spending?
	var expenseType: SpendingType

	init(presenter: UINavigationController, expenseType: SpendingType = .ordinary) {
		self.presenter = presenter
		self.expenseType = expenseType
	}

	func start() {
		let spendingVC = SpendingViewController()
		spendingVC.delegate = self
		spendingVC.title = "Spending"
		let transactionService = TransactionService()
		let budgetService = BudgetService()
		spendingVC.viewModel = SpendingViewModel(transactionService: transactionService,
																						 budgetService: budgetService,
																						 spending: spending,
																						 expenseType: expenseType)

		presenter.pushViewController(spendingVC, animated: true)
		self.spendingViewController = spendingVC
	}
}

extension SpendingCoordinator: SpendingViewControllerDelegate {
	func back() {
		presenter.popViewController(animated: true)
	}
}
