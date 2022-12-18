//
//  ViewController.swift
//  PMM
//
//  Created by Aleksandr Gabrielyan on 18.12.22.
//

import UIKit

class ViewController: UIViewController {
	let transactionService = TransactionService()
	var expenseIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

	@IBAction func addExpense(_ sender: UIButton) {
     let expense = Expense(id: expenseIndex,
													 amount: 4 * expenseIndex,
													 currency: "AMD",
													 description: "expense \(expenseIndex)",
													 date: Date())
		expenseIndex += 1
		transactionService.addExpense(expense: expense)
	}

	@IBAction func removeExpense(_ sender: UIButton) {
		if let firstExpense = transactionService.expenses()?.first {
			transactionService.removeExpense(expense: firstExpense)
		}

	}

	@IBAction func getExpenses(_ sender: UIButton) {
		print(transactionService.expenses())
	}
}

