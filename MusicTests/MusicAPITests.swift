//
//  MusicAPITests.swift
//  MusicTests
//
//  Created by Bola Fayez on 19/04/2023.
//

import XCTest
@testable import Music

final class MusicAPITests: CommunicationManagerProtocol {

    let data: MusicModel?
    let error: Error?
    
    init(data: MusicModel? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }
    
    func request<T>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        if let data = data as? T {
            completion(.success(data))
        } else if let error = error {
            completion(.failure(error))
        } else {
            let error = NSError(domain: "Missed mock", code: 1000, userInfo: [NSLocalizedDescriptionKey : "You missed pass the mocked data"])
            completion(.failure(error))
        }
    }

}
