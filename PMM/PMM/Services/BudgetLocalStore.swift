//
//  BudgetLocalStore.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/30/22.
//

import Foundation

class BudgetLocalStore: LocalStorable, BudgetStorable {


	typealias Entity = Budget

	let defaults = UserDefaults.standard
	let budgetKey = "BudgetP"

	func addOrUpdate(budget: Budget) {
		set(value: budget, for: budgetKey)
	}

	func getBudget() -> Budget? {
		get(for: budgetKey)
	}
}
