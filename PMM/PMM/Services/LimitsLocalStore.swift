//
//  LimitsStorage.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/30/22.
//

import Foundation

class LimitsLocalStore: ExpenceStorable, LocalStorable {

	typealias Entity = Expenses

	let defaults = UserDefaults.standard
	let expensesKey = "LimitsP"

	func addExpense(expense: Spending) {
		var expenses = expenses() ?? []
		expenses.append(expense)
		save(expenses: expenses)
	}

	func expenseFor(id: Int) -> Spending? {
		expenses()?.first(where: { $0.id == id})
	}

	func expenses() -> [Spending]? {
		get(for: expensesKey)?.expenses
	}

	func removeExpense(expense: Spending) {
		let expenses = expenses()
		save(expenses: expenses?.filter({ $0.id != expense.id }))
	}

	func expensesForTimePeriod(start: Date, end: Date) -> [Spending]? {
		let expenses = expenses()
		return expenses?.filter({ ($0.date >= start && $0.date <= end) })
	}

	private func save(expenses: [Spending]?) {
		if let expenses = expenses {
			let expensesModel = Expenses(expenses: expenses)
			set(value: expensesModel, for: expensesKey)
		}
	}
}
