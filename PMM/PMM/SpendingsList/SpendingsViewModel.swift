//
//  SpendingsViewModel.swift
//  PMM
//
//  Created by Vahan Grigoryan on 1/1/23.
//

import Foundation

class SpendingsViewModel {
	private let transaction: TransactionService

	init(transaction: TransactionService) {
		self.transaction = transaction
	}

	var expenses: [Spending]? {
		transaction.expenses()
	}

	var cellModels: [SpendingCellModel]? {
		transaction.expenses()?.map({ SpendingCellModel(amount: "\($0.amount)", title: $0.description, currency: $0.currency) })
	}
}
