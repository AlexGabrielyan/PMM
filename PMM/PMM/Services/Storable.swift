//
//  Storable.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

protocol Unifiable {
	var id: Int { get set }
	var date: Date { get set }
}

protocol ExpenceStorable {
	func addExpense(expense: Spending)
	func expenseFor(id: Int) -> Spending?
	func removeExpense(expense: Spending)
	func expenses() -> [Spending]?
	func expensesForTimePeriod(start: Date, end: Date) -> [Spending]?
}

protocol BudgetStorable {
	func addOrUpdate(budget: Budget)
	func getBudget() -> Budget?
}
