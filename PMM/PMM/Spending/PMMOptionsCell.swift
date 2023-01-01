//
//  PMMOptionsCell.swift
//  PMM
//
//  Created by Vahan Grigoryan on 1/1/23.
//

import UIKit

enum CellOption {
	case normal
	case other
}

class PMMOptionsCell: UICollectionViewCell {

	@IBOutlet weak private var optionLabel: UILabel!

	private var optionType: CellOption?
	var cellModel: OptionCellModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	override func prepareForReuse() {
		optionType = nil
		optionLabel.text = nil
	}

	func config(cellModel: OptionCellModel) {
		optionLabel.text = cellModel.text
		optionType = cellModel.type
		self.cellModel = cellModel
	}
}
