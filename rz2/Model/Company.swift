//
//  Company.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-11.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper
import Alamofire

class Company : Mappable {
    var id : Int = 0
    var token : String = ""
    var name : String = ""
    var company_id : Int = 0
    var has_gps : Bool = false
    var days_to_expired_access : String = ""
    var has_unit_type : Bool = false
    var has_unit_qr_code : Bool = false
    var unit_alias : String = ""
    var access : String = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map : Map) {
        id                      <- map["id"]
        token                   <- map["token"]
        name                    <- map["name"]
        company_id              <- map["company_id"]
        has_gps                 <- map["has_gps"]
        days_to_expired_access  <- map["days_to_expired_access"]
        has_unit_type           <- map["has_unit_type"]
        has_unit_qr_code        <- map["has_unit_qr_code"]
        access                  <- map["access"]
    }
    
    
    static func login(params: [String : Any], completionBlock: @escaping CompanyCompletionBlock){
        let request = API.POST(params)
        request.responseJSON { (response: DataResponse<Any>) in
            if let data = response.result.value as? [String : Any] {
                if let companyDictionary = data["data"] as? [String : Any] {
                    if let company = Company(JSON: companyDictionary) {
                        completionBlock(company, nil)
                    }
                }
            } else if let error = response.result.error {
                completionBlock(nil, error)
            }
        }
    }
    
    func getUnits(token: String, completionBlock: @escaping UnitsCompletionBlock) {
        let request = API.GET(token: token)
        request.responseJSON { (response: DataResponse<Any>) in
            if let result = response.result.value as? [String : Any] {
                if let data = result["data"] as? [String : Any] {
                    if let unitsDictionary = data["units"] as? [[String : Any]] {
                        completionBlock(unitsDictionary, nil)
                    } else if let error = response.result.error {
                        completionBlock(nil, error)
                    }
                }
            }
        }
    }
    
    
}

typealias CompanyCompletionBlock = (_ company: Company?, _ error: Error?) -> Void
typealias UnitsCompletionBlock = (_ units: [[String : Any]]?, _ error: Error?) -> Void
