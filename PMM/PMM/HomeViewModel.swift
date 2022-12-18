//
//  ViewModel.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/18/22.
//

import Foundation

class HomeViewModel {
	var monthlyLimit: String?
	var dailyLimit: String?
	let transactionService: TransactionService

	var expences: [Expense]? {
		transactionService.expenses()
	}

	init(monthlyLimit: String? = nil, dailyLimit: String? = nil, transactionService: TransactionService) {
		self.monthlyLimit = monthlyLimit
		self.dailyLimit = dailyLimit
		self.transactionService = transactionService
	}
}
