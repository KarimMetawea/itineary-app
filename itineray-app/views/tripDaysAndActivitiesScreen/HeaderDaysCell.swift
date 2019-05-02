//
//  HeaderDaysCell.swift
//  itineray-app
//
//  Created by karim metawea on 5/1/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class HeaderDaysCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.font = UIFont(name: Theme.bodyFontBold, size: 20)
        subTitleLabel.font = UIFont(name: Theme.mainFontName, size: 18)
    }

    func configureCell(dayModel:DayModel){
        titleLabel.text = dayModel.title
        subTitleLabel.text = dayModel.subTitle
    }

}
