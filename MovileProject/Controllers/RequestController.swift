//
//  RequestController.swift
//  MovileProject
//
//  Created by iOS on 7/22/15.
//
//

import Foundation
import Alamofire

class RequestController {
    func getShow(id: String, completion: ((Result<Show, NSError?>)-> Void)?){
        Alamofire.request(.GET, <#URLString: URLStringConvertible#>, parameters: <#[String : AnyObject]?#>, encoding: <#ParameterEncoding#>)
    }
}