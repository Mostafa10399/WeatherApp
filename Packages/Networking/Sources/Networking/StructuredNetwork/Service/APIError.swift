//
//  File.swift
//  
//
//  Created by Mostafa Mahmoud on 30/05/2024.
//

import Foundation

public enum APIError: Equatable, Error {
    case parametersNil
    case encodingFailed
    case missingURL
    case invalidURL
    case badRequest
    case decodingFailed
    case customError(statusCode: Int)
    case requestFailed
}
