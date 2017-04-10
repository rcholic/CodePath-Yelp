//
//  BusinessCell.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import SnapKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var priceyLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
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
        thumbImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(8)
            make.width.height.equalTo(65)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.left.equalTo(thumbImageView.snp.right).offset(8)
        }
        
        ratingImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(thumbImageView.snp.right).offset(8)
            make.width.equalTo(83)
            make.height.equalTo(15)
        }
        
        reviewCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingImageView)
            make.left.equalTo(ratingImageView.snp.right).offset(8)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumbImageView.snp.right).offset(8)
            make.top.equalTo(ratingImageView.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(8)
        }
        
        categoriesLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(addressLabel.snp.leading)
            make.left.equalTo(thumbImageView.snp.right).offset(8)
            make.top.equalTo(addressLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(10)
        }
        
        priceyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(reviewCountLabel)
            make.right.equalToSuperview().inset(8)
        }
        
        distanceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().inset(8)
//            make.left.greaterThanOrEqualTo(nameLabel.snp.right).offset(8)
        }
        
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byWordWrapping
        addressLabel.lineBreakMode = .byWordWrapping
    }
    
    private func randomPriceyness() -> String {
        let priceyness: [String] = ["$", "$$", "$$$", "$$$$"]
        let randomIndex = Int(arc4random_uniform(UInt32(priceyness.count)))
        return priceyness[randomIndex]
    }
    
    private func bind(_ restaurant: Restaurant) {
        
        thumbImageView.fadeInImageWith(remoteImgUrl: restaurant.imageUrl, placeholderImage: nil)
        
        if let name = restaurant.name {
            nameLabel.text = name
        }
        
        if let dist = restaurant.distance {
            let miles = Double(dist) * milesPerMeter
            distanceLabel.text = "\(String(format: "%.2f", miles)) mi"
        }
        
        if let urlString = restaurant.ratingImageUrl {
            ratingImageView.setImageWith(URL(string: urlString)!)
        }
        
        var reviewLabelContent = "No Reviews"
        if let reviewCount = restaurant.reviewCount, reviewCount > 0 {
            reviewLabelContent = "\(reviewCount) "
            reviewLabelContent += reviewCount > 1 ? "Reviews" : "Review"
        }
        
        reviewCountLabel.text = reviewLabelContent
        
        addressLabel.text = restaurant.address.joined(separator: ", ")
        
        categoriesLabel.text = restaurant.categories.first?.joined(separator: ", ")
        
        priceyLabel.text = randomPriceyness()
    }
    
}
