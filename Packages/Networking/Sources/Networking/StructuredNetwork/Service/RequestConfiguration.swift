//
//  RequestConfiguration.swift
//  
//
//  Created by Mostafa Mahmoud on 30/05/2024.
//

import Foundation

public struct RequestConfiguration {

    // MARK: - Properties
    
    let path: String
    let method: HTTPMethod
    let headers: [HTTPHeader]?
    let parameters: Parameters?
    let encoding: ParameterEncoding?

    // MARK: - Methods
    
    internal init(method: HTTPMethod = .get,
                  path: String,
                  headers: [HTTPHeader]? = nil,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = .UrlEncoding) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}
