//
//  DefaultStoreManager.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

class ExpensesLocalStore : ExpenceStorable, LocalStorable {

	typealias Entity = Expenses

	let defaults = UserDefaults.standard
	let expensesKey = "OurExpensesP"

	func addExpense(expense: Expense) {
		var expenses = expenses() ?? []
		expenses.append(expense)
		save(expenses: expenses)
	}

	func expenseFor(id: Int) -> Expense? {
		expenses()?.first(where: { $0.id == id})
	}

	func expenses() -> [Expense]? {
		get(for: expensesKey)?.expenses
	}

	func removeExpense(expense: Expense) {
		let expenses = expenses()
		save(expenses: expenses?.filter({ $0.id != expense.id }))
	}

	func expensesForTimePeriod(start: Date, end: Date) -> [Expense]? {
		let expenses = expenses()
		return expenses?.filter({ ($0.date >= start && $0.date <= end) })
	}

	private func save(expenses: [Expense]?) {
		if let expenses = expenses {
			let expensesModel = Expenses(expenses: expenses)
			set(value: expensesModel, for: expensesKey)
		}
	}
}

protocol LocalStorable {
	associatedtype Entity: Codable
	func set(value: Entity, for key: String)
	func get(for key: String) -> Entity?
}

extension LocalStorable {

	func set(value: Entity, for key: String) {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(value) {
			let defaults = UserDefaults.standard
			defaults.set(encoded, forKey: key)
		}
	}

	func get(for key: String) -> Entity? {
		if let savedExpenses = UserDefaults.standard.object(forKey: key) as? Data {
			let decoder = JSONDecoder()
			if let expenses = try? decoder.decode(Entity.self, from: savedExpenses) {
				return expenses
			}
		}
		return nil
	}
}

