//
//  File.swift
//  
//
//  Created by Mostafa Mahmoud on 30/05/2024.
//

import Foundation

public enum ParameterEncoding {
    
    case UrlEncoding
    case JsonEncoding
    
    public func encode(urlRequest: inout URLRequest, parameters: Parameters?) throws {
        do {
            switch self {
            case .UrlEncoding:
                guard let urlParameters = parameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest,
                                                 with: urlParameters)
                
            case .JsonEncoding:
                guard let bodyParameters = parameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest,
                                                  with: bodyParameters)
            }
        }catch {
            throw error
        }
    }
}
