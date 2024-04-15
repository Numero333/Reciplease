//
//  AlamofireService.swift
//  Reciplease
//
//  Created by François-Xavier on 13/03/2024.
//

import Foundation
import Alamofire

protocol AlamofireSessionProtocol {
    func performRequest<T: Decodable>(apiRequest: APIConfiguration) async throws -> T
}

final class NetworkService: AlamofireSessionProtocol {
    
    let session: Session
    
    init(session: Session = Session()){
        self.session = session
    }
            
    func performRequest<T: Decodable>(apiRequest: APIConfiguration) async throws -> T {
        return try await AF.request(apiRequest.url.value, method: apiRequest.method, parameters: apiRequest.parameters.value)
            .serializingDecodable(T.self).value
    }
}
