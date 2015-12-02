//
//  CastModel.swift
//  Rotter2
//
//  Created by Le Thanh Tan on 11/10/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class CastModel: Mappable {

    var name: String!
    var id: String!
    var characters: String!
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        characters <- map["characters"]
    }

}



