//
//  Budget.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

struct Budget: Codable {
	var income: Int
	let spendings: [Spending]
	let currency: String
	let monthlyLimit: Int
}
