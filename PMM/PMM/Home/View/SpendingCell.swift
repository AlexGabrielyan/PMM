//
//  SpendingCell.swift
//  PMM
//
//  Created by Vahan Grigoryan on 12/29/22.
//

import UIKit

struct SpendingCellModel {
	let amount: String
	let title: String
	let currency: String
}

class SpendingCell: UITableViewCell {

	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configUI(viewModel: SpendingCellModel?) {
		if let viewModel = viewModel {
			amountLabel.text = viewModel.amount
			titleLabel.text = viewModel.title
		}
	}
}
