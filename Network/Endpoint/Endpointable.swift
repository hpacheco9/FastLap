//
//  Endpointable.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation


protocol Endpointable {
    var path: String { get }
    var scheme: String { get }
    var method: HttpMethod { get }
    var host: String { get }
    var headers: [String: String] { get }
    var parameters: [URLQueryItem]? { get }
    var url: URL? { get }
}



extension Endpointable {
    var scheme: String { "https" }
    var method: HttpMethod { .get }
    var host: String { "v1.formula-1.api-sports.io"}
    
    var headers: [String: String] {
        ["x-rapidapi-host": "v1.formula-1.api-sports.io",
        "x-rapidapi-key": "3798c3857b8b8825d148f2416dc5e007"]
    }
    
  
    
    var url: URL? {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = parameters

        return components.url
        
    }
    
    func urlRequest(url: URL) -> URLRequest {
        
       var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
        
    }
    

    
    
}



