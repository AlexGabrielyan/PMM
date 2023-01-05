//
//  SpendingViewModel.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/28/22.
//

import Foundation

enum SpendingType {
	case monthly
	case ordinary
}

final class SpendingViewModel {
	let transactionService: TransactionService
	let budgetService: BudgetService
	var expenseDate: Date?
	var expenseTitle: String?
	var expenseAmount: String?
	var expenseCurrency: String?
	var expenseType: SpendingType?

	init(transactionService: TransactionService,
			 budgetService: BudgetService,
			 spending: Spending?,
			 expenseType: SpendingType?) {
		self.transactionService = transactionService
		self.budgetService = budgetService
		self.expenseDate = spending?.date
		self.expenseTitle = spending?.description
		self.expenseAmount = String(spending?.amount ?? 0)
		self.expenseCurrency = spending?.currency
		self.expenseType = expenseType
	}

	func saveExpense() {
		let expenseDate = expenseDate ?? Date()
		let expense = Spending(id: Int(expenseDate.timeIntervalSince1970),
													 amount: Int(expenseAmount ?? "0") ?? 0,
													 currency: expenseCurrency ?? "AMD",
													 description: expenseTitle ?? "expense",
													 date: expenseDate)
		switch expenseType {
		case .ordinary:
			transactionService.addExpense(expense: expense)
		case .monthly:
			budgetService.addExpense(spending: expense)
		case .none:
			break
		}

	}
}

