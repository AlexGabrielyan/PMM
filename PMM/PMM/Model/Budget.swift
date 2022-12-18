//
//  Budget.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

struct Budget: Codable {
	let income: Int
	let spendings: [Expense]
	let currency: String
	let monthlyLimit: Int
}
