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
	
	func addExpense(expense: Expense) {
		store.addExpense(expense: expense)
	}
	
	func removeExpense(expense: Expense) {
		store.removeExpense(expense: expense)
	}
	
	func expenseFor(id: Int) -> Expense? {
		store.expenseFor(id: id)
	}
	
	func expenses() -> [Expense]? {
		store.expenses()
	}
	
	func expensesForTimePeriod(start: Date, end: Date) -> [Expense]? {
		store.expensesForTimePeriod(start: start, end: end)
	}
}


