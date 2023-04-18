//
//  MusicModel.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import Foundation

struct MusicModel: Codable {
    
    let resultCount: Int
    let results: [Results]
    
    struct Results: Codable {
        
        let wrapperType: String?
        let kind: String?
        let artistId: Int?
        let collectionId: Int?
        let trackId: Int?
        let artistName: String?
        let collectionName: String?
        let trackName: String?
        let collectionCensoredName: String?
        let trackCensoredName: String?
        let collectionArtistId: Int?
        let collectionArtistName: String?
        let artistViewUrl: String?
        let collectionViewUrl: String?
        let trackViewUrl: String?
        let previewUrl: String?
        let artworkUrl30: String?
        let artworkUrl60: String?
        let artworkUrl100: String?
        let collectionPrice: Int?
        let trackPrice: Int?
        let releaseDate: String?
        let collectionExplicitness: String?
        let trackExplicitness: String?
        let discCount: Int?
        let discNumber: Int?
        let trackCount: Int?
        let trackNumber: Int?
        let trackTimeMillis: Int?
        let country: String?
        let currency: String?
        let primaryGenreName: String?
        let isStreamable: Bool?
    }

}
