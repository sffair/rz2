//
//  Constants.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-11.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//
//  Constantes e typealias necessárias para o projeto
//

import UIKit

public struct APISettings {
    static let MAIN_URL = "http://54.208.92.83/checklist_novo/Application/public/mobile"
}

public struct EndPoints {
    static let Login = "/login"
    static let Units = "/units"
}

public struct CoreDataSettings {
    static let Entity = "Units"
    static let ModelName = "Data"
}

struct Colors {
    
    static let orangeApp   = UIColor(red: 255.0/255.0, green: 90.0/255.0, blue: 0, alpha: 1)
    static let greenApp    = UIColor(red: 21.0/255.0, green: 178.0/255.0, blue: 89.0/255.0, alpha: 1)
    
}



typealias CompanyCompletionBlock = (_ company: Company?, _ error: Error?) -> Void
typealias UnitsCompletionBlock = (_ units: [[String : Any]]?, _ error: Error?) -> Void
typealias SuccessCompletionBlock = (_ success: Bool, _ error: Error?) -> Void
