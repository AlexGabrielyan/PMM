//
//  DailyLimitViewController.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/28/22.
//

import UIKit

protocol Backable {
	func back()
}

protocol DailyLimitViewControllerDelegate: AnyObject, Backable {
	func goToAddSpending()
	func goToSpending(spending: Spending?)
}

class DailyLimitViewController: UIViewController {
	weak var delegate: DailyLimitViewControllerDelegate?
	var viewModel: DailyLimitsViewModel?

	@IBOutlet weak var spendingsListTableView: UITableView!
	@IBOutlet weak var amountTextField: UITextField!
	@IBOutlet weak var totalAmountLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

		initialConfig()
		updateUI()
	}

	func initialConfig() {
		spendingsListTableView.register(UINib(nibName: "SpendingCell", bundle: nil), forCellReuseIdentifier: "SpendingCell")
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
	}

	func updateUI() {
		if let viewModel = viewModel {
			amountTextField.text = viewModel.income
			totalAmountLabel.text = viewModel.totalAmount 
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateUI()
	}

	@IBAction func addSpending(_ sender: UIButton) {
		delegate?.goToAddSpending()
	}

	@objc func saveTapped() {
		viewModel?.income = amountTextField.text
		viewModel?.save()
		delegate?.back()
	}
}

extension DailyLimitViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.cellModels?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell") as! SpendingCell
		cell.configUI(viewModel: viewModel?.cellModels?[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.goToSpending(spending: viewModel?.spendings?[indexPath.row])
	}
}

extension DailyLimitViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		viewModel?.income = textField.text
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return true
	}
}
