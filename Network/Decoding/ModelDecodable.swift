//
//  ModelDecodable.swift
//  testev2
//
//  Created by Henrique Pacheco on 10/04/2025.
//

import Foundation


protocol ModelDecodable {
    func decode<T: Decodable>(_ type: T.Type, data: Data) throws -> T
}

extension ModelDecodable {
    func decode<T: Decodable>(_ type: T.Type, data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
