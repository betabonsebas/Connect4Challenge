//
//  ChipCollectionViewCell.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class ChipCollectionViewCell: UICollectionViewCell {

    @IBOutlet var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
    
    func configure(with chip: Chip) {
        colorView.backgroundColor = chip.color
    }
}
