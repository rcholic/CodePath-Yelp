//
//  RestaurantTableViewCell.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var restaurant: Restaurant! {
        didSet {
            self.thumbImageView.fadeInImageWith(remoteImgUrl: restaurant.imageUrl, placeholderImage: nil)
            
            if let name = restaurant.name {
                self.nameLabel.text = name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbImageView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
