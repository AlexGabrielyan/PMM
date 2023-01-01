//
//  TransactionService.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

protocol TransactionSupportable {
}

class TransactionService {
	
	private let store: ExpenceStorable
	
	init() {
		self.store = ExpensesLocalStore()
	}
	
	func addExpense(expense: Spending) {
		store.addExpense(expense: expense)
	}
	
	func removeExpense(expense: Spending) {
		store.removeExpense(expense: expense)
	}
	
	func expenseFor(id: Int) -> Spending? {
		store.expenseFor(id: id)
	}
	
	func expenses() -> [Spending]? {
		store.expenses()
	}
	
	func expensesForTimePeriod(start: Date, end: Date) -> [Spending]? {
		store.expensesForTimePeriod(start: start, end: end)
	}
}


