//
//  CommunicationManager.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import Foundation

protocol CommunicationManagerProtocol {
    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

class CommunicationManager: CommunicationManagerProtocol {

    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error)); return
            }
            if let data = data {
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
