//
//  Unities.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-11.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class Unit : Mappable {
    var id: Int = 13215
    var name: String = ""
    var email : String = ""
    var address: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var country: Country?
    var state: State?
    var city: City?
    var type: String?
    var checklists_ids: [Int?]?
    var regions_ids: [Int?]?
    var additional_fields: [String?]?
    var qr_code: String?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map : Map) {
        name    <- map["name"]
        
    }
    
}
