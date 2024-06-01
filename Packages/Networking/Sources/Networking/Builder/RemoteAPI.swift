//
//  File.swift
//  
//
//  Created by Mostafa Mahmoud on 31/05/2024.
//

import Foundation
import Combine

public protocol RemoteAPI {
    func request<T: Codable>(_ service: RemoteService) -> AnyPublisher<APIResponse<T>, APIError>
}

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}

extension RemoteAPI {
    
    private func getUrlRequest(_ service: RemoteService) -> AnyPublisher<URLRequest, APIError> {
        Result {
             try service.asURLRequest()
         }
        .mapError({ error -> APIError in
            guard let error = error as? APIError else {
                return APIError.decodingFailed
            }
            return error
        })
        .publisher
        .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(_ service: RemoteService) -> AnyPublisher<APIResponse<T>, APIError> {
        getUrlRequest(service)
        .flatMap { request in
            URLSession.shared.dataTaskPublisher(for: request)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .tryMap { data, response -> Data in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.badRequest
                    }
                    guard (200 ... 299).contains(httpResponse.statusCode) else {
                        throw APIError.customError(statusCode: httpResponse.statusCode)
                    }
                    return data
                }
                .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
                .mapError({ error -> APIError in
                    guard let error = error as? APIError else {
                        return APIError.decodingFailed
                    }
                    return error
                })
        }
        .eraseToAnyPublisher()
    }
}
