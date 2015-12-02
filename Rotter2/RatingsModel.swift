//
//  RatingsModel.swift
//  Rotter2
//
//  Created by Le Thanh Tan on 11/10/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class RatingsModel: Mappable {
    
    var critics_rating: String?
    var critics_score: String?
    var audience_rating: String?
    var audience_score: String?
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        critics_rating <- map["critics_rating"]
        critics_score <- map["critics_score"]
        audience_rating <- map["audience_rating"]
        audience_score  <- map["audience_score"]
    }

}


