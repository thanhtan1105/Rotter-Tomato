//
//  MovieModel.swift
//  Rotter2
//
//  Created by Le Thanh Tan on 11/10/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class MovieModel: Mappable {

    var id: String?
    var title: String?
    var year: String?
    var mpaa_rating: String?
    var runtime: String?
    var critics_consensus: String?
    var release_dates: NSDictionary?
    var ratings: RatingsModel?
    var synopsis: String?
    var poster: PosterModel?
    var casts: Array<CastModel>?
    var alternate_ids: NSDictionary?
    var links: NSDictionary?
    
    required init?(_ map: Map){
        
    }

    func mapping(map: Map) {
        id  <- map["id"]
        title <- map["title"]
        year <- map["year"]
        mpaa_rating <- map["mpaa_rating"]
        runtime <- map["runtime"]
        critics_consensus <- map["critics_consensus"]
        release_dates <- map[".release_dates"]
        ratings <- map["ratings"]
        synopsis <- map["synopsis"]
        poster <- map["posters"]
        casts <- map["abridged_cast"]
        alternate_ids <- map["alternate_ids"]
        links <- map["links"]
    }
}
