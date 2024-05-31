//
//  File.swift
//  
//
//  Created by Mostafa Mahmoud on 30/05/2024.
//

import Foundation

public protocol RemoteService {
    var baseURL: String { get }
    var requestConfiguration: RequestConfiguration { get }
}

extension RemoteService {
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL
            .asURL()
            .appendingPathComponent(requestConfiguration.path)
        var request = URLRequest(url: url)
        request.httpMethod = requestConfiguration.method.rawValue
        if let headers = requestConfiguration.headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        if let parameters = requestConfiguration.parameters {
            try requestConfiguration.encoding?.encode(
                urlRequest: &request, parameters: parameters)
        }
        return request
    }
}
