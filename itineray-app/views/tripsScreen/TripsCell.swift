//
//  TripsCell.swift
//  itineray-app
//
//  Created by karim metawea on 4/15/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class TripsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cellBackGroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.addShadowAndRoundedCorners()
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 32)
        cellBackGroundImage.layer.cornerRadius = 10
    }
    
    func configureCell(trip:TripModel){
        self.titleLabel.text = trip.title
        self.cellBackGroundImage.image = trip.image
    }
    

}
