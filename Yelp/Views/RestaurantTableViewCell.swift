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
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceyLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var restaurant: Restaurant! {
        didSet {
            self.bind(restaurant)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    private func randomPriceyness() -> String {
        let priceyness: [String] = ["$", "$$", "$$$", "$$$$"]
        let randomIndex = Int(arc4random_uniform(UInt32(priceyness.count)))
        return priceyness[randomIndex]
    }
    
    private func bind(_ restaurant: Restaurant) {
        
        self.thumbImageView.fadeInImageWith(remoteImgUrl: restaurant.imageUrl, placeholderImage: nil)
        
        if let name = restaurant.name {
            self.nameLabel.text = name
        }
        
        if let dist = restaurant.distance {
            let miles = Double(dist) * milesPerMeter
            distanceLabel.text = "\(String(format: "%.2f", miles)) mi"
        }
        
        if let urlString = restaurant.ratingImageUrl {
            self.ratingImageView.setImageWith(URL(string: urlString)!)
        }
        
        var reviewLabelContent = "No Reviews"
        if let reviewCount = restaurant.reviewCount, reviewCount > 0 {
            reviewLabelContent = "\(reviewCount) "
            reviewLabelContent += reviewCount > 1 ? "Reviews" : "Review"
        }
        
        self.reviewCountLabel.text = reviewLabelContent
        
        self.addressLabel.text = restaurant.address.joined(separator: ", ")
        
        self.categoryLabel.text = restaurant.categories.first?.joined(separator: ", ")
        
        priceyLabel.text = randomPriceyness()
    }
    
}
