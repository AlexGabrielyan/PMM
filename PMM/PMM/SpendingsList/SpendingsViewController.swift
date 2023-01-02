//
//  SpengingsViewController.swift
//  PMM
//
//  Created by Vahan Grigoryan on 1/1/23.
//

import UIKit

protocol SpendingsViewControllerDelegate: AnyObject, Backable {
	func goToSpending(spending: Spending)
	func goToAddSpending()
}

class SpendingsViewController: UIViewController {
	var viewModel: SpendingsViewModel?
	weak var delegate: SpendingsViewControllerDelegate?

	@IBOutlet weak var spendings: UITableView!

	override func viewDidLoad() {
        super.viewDidLoad()
		initioaConfigs()
    }

	func initioaConfigs() {
		spendings.register(UINib(nibName: "SpendingCell", bundle: nil), forCellReuseIdentifier: "SpendingCell")
	}

	func updateUI() {
		spendings.reloadData()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateUI()
	}

	@IBAction func addExpense(_ sender: UIButton) {
		delegate?.goToAddSpending()
        sender.backgroundColor = .red
	}
}

extension SpendingsViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel?.cellModels?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell") as! SpendingCell
		cell.configUI(viewModel: viewModel?.cellModels?[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.goToSpending(spending: viewModel?.expenses?[indexPath.row] ?? Spending(id: -1, amount: 0, currency: "AMD", description: "", date: Date()))
	}
}
