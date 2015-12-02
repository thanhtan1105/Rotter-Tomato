
//  MovieCell.swift
//  Rotter2
//
//  Created by Le Thanh Tan on 11/9/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var pgAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
