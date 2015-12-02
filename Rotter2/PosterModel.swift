//
//  PosterModel.swift
//  Rotter2
//
//  Created by Le Thanh Tan on 11/10/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class PosterModel: Mappable {

    var thumbnailURL: String!
    var detailedURL: String!
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        thumbnailURL <- map["thumbnail"]
        detailedURL <- map["detailed"]
    }

}
