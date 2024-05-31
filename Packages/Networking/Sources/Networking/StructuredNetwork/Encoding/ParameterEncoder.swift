//
//  File.swift
//  
//
//  Created by Mostafa Mahmoud on 30/05/2024.
//

import Foundation

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
