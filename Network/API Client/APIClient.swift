//
//  APIClient.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation

protocol APIClientFetchable {
    func fetch(endpoint: Endpointable) async throws -> Data
}


final class APIClient {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}


extension APIClient: APIClientFetchable {
    func fetch(endpoint: Endpointable) async throws -> Data {
        guard let url =  endpoint.url else {
            throw URLError(.badURL)
        }
        let (data, response) = try await session.data(from: url)
    
        guard response is HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        return data

    }
}
