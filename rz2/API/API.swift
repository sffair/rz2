//
//  File.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-11.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//
//  API contendo as chamadas GET e POST necessárias para o projeto, utilizando Alamofire
//

import Foundation
import UIKit
import Alamofire

class API : NSObject {
    
    static func POST(_ params: Alamofire.Parameters?=nil) -> DataRequest {
        let url = APISettings.MAIN_URL + EndPoints.Login
        return Alamofire.request(url, method: .post, parameters: params)
            .response {
                response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                debugPrint("===================== REQUEST ===================")
                if let absoluteURL = response.response?.url?.absoluteString {
                    debugPrint("URL: \(absoluteURL)")
                }
                
                
                if let statusCode = response.response?.statusCode {
                    debugPrint("StatusCode: \(statusCode)")
                }
                
                if let parameters = response.request?.allHTTPHeaderFields {
                    debugPrint("HTTP Parameters: \(parameters)")
                }
                
                if let params = params {
                    debugPrint("Params: \(params)")
                }
                
                debugPrint("==================== ./ REQUEST ==================")
        }
    }
    
    static func GET(token: String) -> DataRequest {
        let url = APISettings.MAIN_URL + EndPoints.Units
        let tokenWithBearer = "Bearer \(token)"
        let header : HTTPHeaders = ["Authorization" : tokenWithBearer]
        return Alamofire.request(url, method: .get, headers: header)
            .response {
                response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                debugPrint("===================== REQUEST ===================")
                if let absoluteURL = response.response?.url?.absoluteString {
                    debugPrint("URL: \(absoluteURL)")
                }
                
                
                if let statusCode = response.response?.statusCode {
                    debugPrint("StatusCode: \(statusCode)")
                }
                
                if let parameters = response.request?.allHTTPHeaderFields {
                    debugPrint("HTTP Parameters: \(parameters)")
                }
                
                debugPrint("==================== ./ REQUEST ==================")
            }
        
        }
    
}
