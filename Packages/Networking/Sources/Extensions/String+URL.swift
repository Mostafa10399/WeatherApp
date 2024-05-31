//
//  String+URL.swift
//
//
//  Created by Mostafa Mahmoud on 30/05/2024.
//

import Foundation

extension String {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.invalidURL }
        return url
    }
}
