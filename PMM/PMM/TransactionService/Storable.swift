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
	func addExpense(expense: Expense)
	func expenseFor(id: Int) -> Expense?
	func removeExpense(expense: Expense)
	func expenses() -> [Expense]?
	func expensesForTimePeriod(start: Date, end: Date) -> [Expense]?
}

