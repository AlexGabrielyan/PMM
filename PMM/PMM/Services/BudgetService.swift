//
//  DailyLimitationService.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/30/22.
//

import Foundation

class BudgetService {
	private let store: BudgetStorable

	init() {
		self.store = BudgetLocalStore()
	}

	func addOrUpdate(budget: Budget) {
		store.addOrUpdate(budget: budget)
	}

	func addExpense(expense: Spending) {
		let budget = getBudget()
		var spendings = budget?.spendings ?? []
		spendings.append(expense)
		let newBudget = Budget(income: budget?.income ?? 0,
												spendings: spendings,
												currency: "AMD",
												monthlyLimit: budget?.monthlyLimit ?? 0)
		store.addOrUpdate(budget: newBudget)
	}


	func getBudget() -> Budget? {
		store.getBudget()
	}
}
