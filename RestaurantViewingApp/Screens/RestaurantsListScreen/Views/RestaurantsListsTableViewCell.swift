//
//  RestaurantsListsTableViewCell.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit

class RestaurantsListsTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    @IBOutlet weak var restaurantMarkerImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
