//
//  DailyLimitsViewModel.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/19/22.
//

import Foundation

final class DailyLimitsViewModel {
	let budgetService: BudgetService

	init(budgetSercice: BudgetService) {
		self.budgetService = budgetSercice
		self.income = String(budgetService.getBudget()?.income ?? 0)
	}

	var income: String?

	var budget: Budget? {
		budgetService.getBudget()
	}

	var spendings: [Spending]? {
		budgetService.getBudget()?.spendings
	}

	var totalAmount: String? {
		String(spendings?.map({ $0.amount }).reduce(0, +) ?? 0) + " AMD"
	}

	var cellModels: [SpendingCellModel]? {
		spendings?.map({ SpendingCellModel(amount: "\($0.amount)", title: $0.description, currency: $0.currency) })
	}

	func save() {
		let incomeAmount = Int(income ?? "0") ?? 0
		let spendingsAmount = Int(totalAmount ?? "0") ?? 0
		let bugdet = Budget(income: incomeAmount,
												spendings: spendings ?? [],
												currency: "AMD",
												monthlyLimit: incomeAmount - spendingsAmount)
		budgetService.addOrUpdate(budget: bugdet)
	}
}
