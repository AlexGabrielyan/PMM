//
//  Expense.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

struct Expenses: Codable {
	var expenses: [Expense]
}

struct Expense: Codable, Unifiable {
	var id: Int
	let amount: Int
	let currency: String
	let description: String
	var date: Date
}

