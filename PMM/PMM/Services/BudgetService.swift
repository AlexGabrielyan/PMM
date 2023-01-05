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

	func addExpense(spending: Spending) {
		let budget = getBudget()
		var spendings = budget?.spendings ?? []
		if let index = budget?.spendings.firstIndex(where: { $0.id == spending.id }) {
			spendings[index] = spending
		} else {
			spendings.append(spending)
		}
		let newBudget = Budget(income: budget?.income ?? 0,
												spendings: spendings,
												currency: "AMD",
												monthlyLimit: budget?.monthlyLimit ?? 0)
		store.addOrUpdate(budget: newBudget)
	}

	func remove(spending: Spending) {
		let budget = getBudget()
		let spendings = budget?.spendings.filter({ $0.id != spending.id })
		let newBudget = Budget(income: budget?.income ?? 0,
												spendings: spendings ?? [],
												currency: "AMD",
												monthlyLimit: budget?.monthlyLimit ?? 0)
		store.addOrUpdate(budget: newBudget)
	}

	func getBudget() -> Budget? {
		store.getBudget()
	}
}
