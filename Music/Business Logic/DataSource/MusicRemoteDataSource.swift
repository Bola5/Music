//
//  MusicRemoteDataSource.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import Foundation

// MARK: - Protocol
protocol MusicRemoteDataSourceProtocol {
    func fetchMusics(term: String, limit: Int, completion: @escaping (Result<MusicModel, Error>) -> Void)
}

// MARK: - Music DataSource
class MusicRemoteDataSource: MusicRemoteDataSourceProtocol {

    private let communicationManagerProtocol: CommunicationManagerProtocol
    
    init(communicationManagerProtocol: CommunicationManagerProtocol = CommunicationManager()) {
        self.communicationManagerProtocol = communicationManagerProtocol
    }
    
    func fetchMusics(term: String, limit: Int, completion: @escaping (Result<MusicModel, Error>) -> Void) {
        
        let endPointURL = EndPoint(action: .getMusics(term: term, limit: limit)).asRequest()
        
        communicationManagerProtocol.request(urlString: endPointURL, completion: { (result : Result<MusicModel, Error>) in
            switch result {
                case .success(let model):
                completion(.success(model))
                case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

// MARK: - EndPoint
extension MusicRemoteDataSource {
    
    private struct EndPoint {
        
        enum Request {
            case getMusics(term: String, limit: Int)
        }
        
        var action: Request
                
        var url: URL? {
            var urlComponents = URLComponents(string: Strings.URL.BASE_URL)!
            
            switch action {
            case .getMusics(let term, let limit):
                urlComponents.path.append(Strings.URL.ENDPOINT)
                
                urlComponents.queryItems = [
                    URLQueryItem(name: "term", value: term),
                    URLQueryItem(name: "media", value: Strings.URL.MEDIA),
                    URLQueryItem(name: "country", value: Strings.URL.COUNTRY_CODE),
                    URLQueryItem(name: "limit", value: "\(limit)")
                ]
                
                return urlComponents.url!
            }
            
        }
        
        init(action: Request) {
            self.action = action
        }
        
        func asRequest() -> String {
            guard let url = url else {
                preconditionFailure("Missing URL for route: \(self)")
            }

            return url.description
        }

    }
    
}
