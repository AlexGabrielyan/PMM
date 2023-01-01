//
//  SpendingViewController.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/28/22.
//

import UIKit

struct PMMConstants {
	static let amountConstants = ["+", "1000", "2000", "3000", "5000", "10000", "15000"]
	static let titleConstants = ["+", "🏡 rent", "🍧 lunch", "🚕 taxi", "🛢 petrol"]
}

protocol SpendingViewControllerDelegate: AnyObject, Backable {}

class SpendingViewController: UIViewController {
	var viewModel: SpendingViewModel?
	weak var delegate: SpendingViewControllerDelegate?

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var amountTextField: UITextField!
	@IBOutlet weak var expenceTitleTextField: UITextField!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var titleOptionsColletionVIew: UICollectionView!
	@IBOutlet weak var amountsCollectionView: UICollectionView!


	override func viewDidLoad() {
		super.viewDidLoad()
		initialConfigs()
		setupUI()
	}

	func initialConfigs() {
		titleOptionsColletionVIew.register(UINib(nibName: "PMMOptionsCell", bundle: nil), forCellWithReuseIdentifier: "PMMOptionsCell")
		amountsCollectionView.register(UINib(nibName: "PMMOptionsCell", bundle: nil), forCellWithReuseIdentifier: "PMMOptionsCell")
	}

	func setupUI() {
		titleTextField.text = viewModel?.expenseTitle
		amountTextField.text = viewModel?.expenseAmount
		datePicker.date = viewModel?.expenseDate ?? Date()
	}

	@IBAction func dateSelected(_ sender: UIDatePicker) {
		viewModel?.expenseDate = sender.date
	}

	@IBAction func savePressed(_ sender: Any) {
		viewModel?.expenseAmount = amountTextField.text
		viewModel?.expenseTitle = titleTextField.text
		viewModel?.saveExpense()
		delegate?.back()
	}
}

extension SpendingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == titleOptionsColletionVIew {
			return PMMConstants.titleConstants.count
		} else {
			return PMMConstants.amountConstants.count
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == titleOptionsColletionVIew {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PMMOptionsCell", for: indexPath) as! PMMOptionsCell
			cell.config(cellModel: OptionCellModel(text: PMMConstants.titleConstants[indexPath.row],
																						 type: indexPath.row == 0 ? .other : .normal))
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PMMOptionsCell", for: indexPath) as! PMMOptionsCell
			cell.config(cellModel: OptionCellModel(text: PMMConstants.amountConstants[indexPath.row],
																						 type: indexPath.row == 0 ? .other : .normal))
			return cell
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let myString: String
		if collectionView == titleOptionsColletionVIew {
			myString = PMMConstants.titleConstants[indexPath.row]
		} else {
			myString = PMMConstants.amountConstants[indexPath.row]
		}
		let textWidth = myString.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 30
		return CGSize.init(width: textWidth, height: 30)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? PMMOptionsCell {
			if collectionView == titleOptionsColletionVIew {
				switch cell.cellModel?.type {
				case .normal:
					titleTextField.text = cell.cellModel?.text
				case .other:
					break
				case .none:
					break
				}
			} else {
				switch cell.cellModel?.type {
				case .normal:
					amountTextField.text = cell.cellModel?.text
				case .other:
					break
				case .none:
					break
				}
			}
		}
	}
}

extension SpendingViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField == amountTextField {
			viewModel?.expenseAmount = textField.text
		} else if textField == titleTextField {
			viewModel?.expenseTitle = textField.text
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return true
	}
}
