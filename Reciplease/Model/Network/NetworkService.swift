//
//  AlamofireService.swift
//  Reciplease
//
//  Created by François-Xavier on 13/03/2024.
//

import Foundation
import Alamofire

final class NetworkService {
            
    func performRequest<T: Decodable>(apiRequest: APIConfiguration) async throws -> T {
        return try await AF.request(apiRequest.url.value, method: apiRequest.method, parameters: apiRequest.parameters.value)
            .serializingDecodable(T.self).value
    }
}
