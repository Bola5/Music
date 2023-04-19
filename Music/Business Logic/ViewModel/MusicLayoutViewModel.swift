//
//  MusicLayoutViewModel.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import Foundation

struct MusicLayoutViewModel {

    let results: [ResultsLayoutViewModel]

    init(musics: MusicModel) {
        self.results = musics.results.compactMap({ ResultsLayoutViewModel(music: $0) })
    }

    struct ResultsLayoutViewModel {
        
        let trackName: String?
        let artistName: String?
        let releaseDate: String?
        let artworkUrl: String?
        let description: String?
        
        init(music: MusicModel.Results) {
            self.trackName = music.trackName
            self.artistName = music.artistName
            self.releaseDate = music.releaseDate
            self.artworkUrl = music.artworkUrl100
            self.description = music.collectionName
        }
        
    }
    
}
