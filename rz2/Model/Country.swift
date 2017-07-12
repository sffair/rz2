//
//  Country.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-11.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Country : Mappable {
    var id: Int = 0
    var nameBr : String = ""
    var nameEn : String = ""
    var nameEs : String = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map : Map) {
        id  <- map["id"]
        nameBr <- map["nameBr"]
        nameEs <- map["nameEs"]
        nameEn <- map["nameEn"]
    }
}
