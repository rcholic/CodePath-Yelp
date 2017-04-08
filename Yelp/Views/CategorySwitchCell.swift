//
//  CategorySwitchCell.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol CategorySwitchCellDelegate: class {
    func categorySwitchCell(cell: CategorySwitchCell, didChangeValue value: Bool)
}

class CategorySwitchCell: UITableViewCell {

    @IBOutlet var countryLabel: UILabel!
    
    @IBOutlet var switchButton: UISwitch!
    
    weak var delegate: CategorySwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchButton.addTarget(self, action: #selector(self.didSwitch(sender:)), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func didSwitch(sender: UISwitch) {
        let value = sender.isOn
        print("isOn? \(value)")
        delegate?.categorySwitchCell(cell: self, didChangeValue: sender.isOn)
    }
    
}
