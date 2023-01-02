//
//  ViewModel.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

class MainViewModel {
	let transactionService: TransactionService
	let budgetService: BudgetService

	var expences: [Spending]? {
		transactionService.expenses()
	}

	var cellModels: [SpendingCellModel]? {
		expences?.map({ SpendingCellModel(amount: "\($0.amount)", title: $0.description, currency: $0.currency) })
	}

	var dailyLimit: String? {
		let monthlyLimit = budgetService.getBudget()?.monthlyLimit ?? 0
		let daysLeft = Calendar(identifier: .gregorian).numberOfDaysBetween(Date(), and:  Date().endOfMonth)
		let monthlyExpense = transactionService.expensesForTimePeriod(start: Date().startOfMonth, end: Date())?.map({ $0.amount }).reduce(0, +) ?? 0
		let amountLeft = monthlyLimit - monthlyExpense
		return String(Int(amountLeft / daysLeft))
	}

	var monthlyLimit: String? {
		String(budgetService.getBudget()?.monthlyLimit ?? 0) + "AMD"
	}

	init(transactionService: TransactionService, budgetService: BudgetService) {
		self.transactionService = transactionService
		self.budgetService = budgetService
	}

	func addExpense(amount: String) {
		let spending = Spending(id: Date().timeIntervalSinceNow.exponent,
														amount: Int(amount) ?? 0,
													 currency: "AMD",
													 description: "💸" + "spending",
													 date: Date())
		transactionService.addExpense(expense: spending)
	}

	func removeExpense(spending: Spending?) {
		if let spending = spending {
			transactionService.removeExpense(expense: spending)
		}
	}
}
