//
//  MainViewController.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/29/22.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject, Backable {
	func goToEditDailyLimit()
	func goToAddSpending()
	func goToSpending(spending: Spending)
	func goToSpendingList()
}

class MainViewController: UIViewController {

	weak var delegate: MainViewControllerDelegate?
	var viewModel: MainViewModel?
	var expenseIndex: Int = 0

	@IBOutlet weak var monthlyLimitLabel: UILabel!
	@IBOutlet weak var dailyLimitLabel: UILabel!
	@IBOutlet weak var spendingsListTableView: UITableView!
	@IBOutlet weak var expensesCollectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		initialConfigs()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		setupUI()
	}

	func initialConfigs() {
		spendingsListTableView.register(UINib(nibName: "SpendingCell", bundle: nil), forCellReuseIdentifier: "SpendingCell")
		expensesCollectionView.register(UINib(nibName: "PMMOptionsCell", bundle: nil), forCellWithReuseIdentifier: "PMMOptionsCell")
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
	}

	func setupUI() {
		dailyLimitLabel.text = viewModel?.dailyLimit
		monthlyLimitLabel.text = viewModel?.monthlyLimit
		spendingsListTableView.reloadData()
	}

	@objc func editTapped() {
		delegate?.goToEditDailyLimit()
	}

	@IBAction func addExpense(_ sender: UIButton) {
		delegate?.goToAddSpending()
	}

	@IBAction func viewSpendingsList(_ sender: UIButton) {
		delegate?.goToSpendingList()
	}

	@IBAction func removeExpense(_ sender: UIButton) {
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.cellModels?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell") as! SpendingCell
		cell.configUI(viewModel: viewModel?.cellModels?[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.goToSpending(spending: viewModel?.expences?[indexPath.row] ?? Spending(id: -1, amount: 0, currency: "AMD", description: "", date: Date()))
	}
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

		func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
			return PMMConstants.amountConstants.count
		}

		func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PMMOptionsCell", for: indexPath) as! PMMOptionsCell
			cell.config(cellModel: OptionCellModel(text: PMMConstants.amountConstants[indexPath.row],
																						 type: indexPath.row == 0 ? .other : .normal))
				return cell
		}

		func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			let myString = PMMConstants.amountConstants[indexPath.row]
			let textWidth = myString.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 30
				return CGSize.init(width: textWidth, height: 30)
		}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? PMMOptionsCell {
			switch cell.cellModel?.type {
			case .normal:
				viewModel?.addExpense(amount: PMMConstants.amountConstants[indexPath.row])
				setupUI()
			case .other:
				delegate?.goToAddSpending()
			case .none:
				break
			}
		}
	}
}

