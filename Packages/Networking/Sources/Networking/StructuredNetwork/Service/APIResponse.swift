//
//  APIResponse.swift
//
//
//  Created by Mostafa Mahmoud on 31/05/2024.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: String
    let data: T?
}

extension APIResponse {
    var success: Bool {
        status == "success"
    }
}
