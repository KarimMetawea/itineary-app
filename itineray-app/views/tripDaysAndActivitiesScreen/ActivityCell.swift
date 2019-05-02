//
//  ActivityCell.swift
//  itineray-app
//
//  Created by karim metawea on 5/1/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.addShadowAndRoundedCorners()
        titleLabel.font = UIFont(name: Theme.bodyFontBold, size: 20)
        subTitleLabel.font = UIFont(name:Theme.mainFontName , size: 16)
        
    }

    func configureCell(activityModel:ActivityModel)  {
        titleLabel.text = activityModel.title
        subTitleLabel.text = activityModel.subTitle
        activityImageView.image = chooseActivityimage(activityType: activityModel.activityType)
    }
    
    func chooseActivityimage(activityType:ActivityType) -> UIImage {
        
        switch activityType{
            
        case .auto:
            return #imageLiteral(resourceName: "car")
        case .unsualActivity:
            return #imageLiteral(resourceName: "hanging-out")
        case .flight:
            return #imageLiteral(resourceName: "flight")
        case .food:
            return #imageLiteral(resourceName: "food")
        case .hotel:
            return #imageLiteral(resourceName: "library")
        }
    }
    
    

}
