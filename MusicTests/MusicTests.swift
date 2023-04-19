//
//  MusicTests.swift
//  MusicTests
//
//  Created by Bola Fayez on 19/04/2023.
//

import XCTest
@testable import Music

final class MusicTests: XCTestCase {

    // MARK: - Properties
    private var viewModel: MusicViewModel!
    private var dataSource: MusicRemoteDataSource!

    // MARK: - tearDown
    override func tearDown() {
        
        viewModel = nil
        dataSource = nil
        
        super.tearDown()
    }
    
    // MARK: - testRetrivedRemoteDataMusics
    func testRetrivedRemoteDataMusics() {
        
        let mockData = MusicModel.parse(jsonFile: "musics")
        let getMusicsAPI = MusicAPITests(data: mockData)
        dataSource = MusicRemoteDataSource(communicationManagerProtocol: getMusicsAPI)
        
        dataSource.fetchMusics(term: "jam", limit: 20, completion: { result in
            switch result {
            case .success(let musicModel):
                
                XCTAssertNotNil(musicModel.results)
                XCTAssertTrue(musicModel.results.count > 0)
                XCTAssertEqual(musicModel.resultCount, 20)
                
                if let firstMusic = musicModel.results.first {
                    XCTAssertEqual(firstMusic.wrapperType, "track")
                    XCTAssertEqual(firstMusic.kind, "song")
                    XCTAssertEqual(firstMusic.artistId, 32940)
                    XCTAssertEqual(firstMusic.collectionId, 336643808)
                    XCTAssertEqual(firstMusic.trackId, 336644171)
                    XCTAssertEqual(firstMusic.artistName, "Michael Jackson")
                    XCTAssertEqual(firstMusic.collectionName, "Michael Jackson's This Is It (The Music That Inspired the Movie)")
                    XCTAssertEqual(firstMusic.trackName, "Jam")
                    XCTAssertEqual(firstMusic.collectionCensoredName, "Michael Jackson's This Is It (The Music That Inspired the Movie)")
                    XCTAssertEqual(firstMusic.trackCensoredName, "Jam")
                    XCTAssertEqual(firstMusic.artistViewUrl, "https://music.apple.com/dk/artist/michael-jackson/32940?uo=4")
                    XCTAssertEqual(firstMusic.collectionViewUrl, "https://music.apple.com/dk/album/jam/336643808?i=336644171&uo=4")
                    XCTAssertEqual(firstMusic.trackViewUrl, "https://music.apple.com/dk/album/jam/336643808?i=336644171&uo=4")
                    XCTAssertEqual(firstMusic.previewUrl, "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/80/90/20/80902024-7d8a-eeb2-b23c-584d1f331ae9/mzaf_12278945373836077860.plus.aac.p.m4a")
                    XCTAssertEqual(firstMusic.artworkUrl30, "https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/2a/82/a5/2a82a59b-6e79-7c39-761a-c1d3b82e93cb/dj.dzbxcmnk.jpg/30x30bb.jpg")
                    XCTAssertEqual(firstMusic.artworkUrl60, "https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/2a/82/a5/2a82a59b-6e79-7c39-761a-c1d3b82e93cb/dj.dzbxcmnk.jpg/60x60bb.jpg")
                    XCTAssertEqual(firstMusic.artworkUrl100, "https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/2a/82/a5/2a82a59b-6e79-7c39-761a-c1d3b82e93cb/dj.dzbxcmnk.jpg/100x100bb.jpg")
                    XCTAssertEqual(firstMusic.collectionPrice, 99)
                    XCTAssertEqual(firstMusic.trackPrice, 10)
                    XCTAssertEqual(firstMusic.releaseDate, "1987-01-01T12:00:00Z")
                    XCTAssertEqual(firstMusic.collectionExplicitness, "notExplicit")
                    XCTAssertEqual(firstMusic.trackExplicitness, "notExplicit")
                    XCTAssertEqual(firstMusic.discCount, 2)
                    XCTAssertEqual(firstMusic.discNumber, 1)
                    XCTAssertEqual(firstMusic.trackCount, 16)
                    XCTAssertEqual(firstMusic.trackNumber, 2)
                    XCTAssertEqual(firstMusic.trackTimeMillis, 338962)
                    XCTAssertEqual(firstMusic.country, "DNK")
                    XCTAssertEqual(firstMusic.currency, "DKK")
                    XCTAssertEqual(firstMusic.primaryGenreName, "Soundtrack")
                    XCTAssertEqual(firstMusic.isStreamable, true)
                    XCTAssertEqual(firstMusic.country, "DNK")
                } else {
                    XCTFail("This should not happen.")
                }
                
                if let lastMusic = musicModel.results.last {
                    XCTAssertEqual(lastMusic.wrapperType, "track")
                    XCTAssertEqual(lastMusic.kind, "song")
                    XCTAssertEqual(lastMusic.artistId, 1356487138)
                    XCTAssertEqual(lastMusic.collectionId, 989446960)
                    XCTAssertEqual(lastMusic.trackId, 989447405)
                    XCTAssertEqual(lastMusic.artistName, "Loco & Jam")
                    XCTAssertEqual(lastMusic.collectionName, "Toolroom Ibiza 2015")
                    XCTAssertEqual(lastMusic.trackName, "Oblivion")
                    XCTAssertEqual(lastMusic.collectionCensoredName, "Toolroom Ibiza 2015")
                    XCTAssertEqual(lastMusic.trackCensoredName, "Oblivion")
                    XCTAssertEqual(lastMusic.collectionArtistId, 331122)
                    XCTAssertEqual(lastMusic.collectionArtistName, "Various Artists")
                    XCTAssertEqual(lastMusic.artistViewUrl, "https://music.apple.com/dk/artist/loco/1356487138?uo=4")
                    XCTAssertEqual(lastMusic.collectionViewUrl, "https://music.apple.com/dk/album/oblivion/989446960?i=989447405&uo=4")
                    XCTAssertEqual(lastMusic.trackViewUrl, "https://music.apple.com/dk/album/oblivion/989446960?i=989447405&uo=4")
                    XCTAssertEqual(lastMusic.previewUrl, "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/fc/0c/1a/fc0c1aee-dcb4-4475-e952-8a20b90af21a/mzaf_16891878266679977509.plus.aac.p.m4a")
                    XCTAssertEqual(lastMusic.artworkUrl30, "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/b3/cc/86/b3cc86f2-82a6-1e2b-6a3c-a1da175b7e6e/5052075012674.png/30x30bb.jpg")
                    XCTAssertEqual(lastMusic.artworkUrl60, "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/b3/cc/86/b3cc86f2-82a6-1e2b-6a3c-a1da175b7e6e/5052075012674.png/60x60bb.jpg")
                    XCTAssertEqual(lastMusic.artworkUrl100, "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/b3/cc/86/b3cc86f2-82a6-1e2b-6a3c-a1da175b7e6e/5052075012674.png/100x100bb.jpg")
                    XCTAssertEqual(lastMusic.collectionPrice, -1)
                    XCTAssertEqual(lastMusic.trackPrice, 10)
                    XCTAssertEqual(lastMusic.releaseDate, "2015-05-04T12:00:00Z")
                    XCTAssertEqual(lastMusic.collectionExplicitness, "notExplicit")
                    XCTAssertEqual(lastMusic.trackExplicitness, "notExplicit")
                    XCTAssertEqual(lastMusic.discCount, 1)
                    XCTAssertEqual(lastMusic.discNumber, 1)
                    XCTAssertEqual(lastMusic.trackCount, 67)
                    XCTAssertEqual(lastMusic.trackNumber, 60)
                    XCTAssertEqual(lastMusic.trackTimeMillis, 398758)
                    XCTAssertEqual(lastMusic.country, "DNK")
                    XCTAssertEqual(lastMusic.currency, "DKK")
                    XCTAssertEqual(lastMusic.primaryGenreName, "Dance")
                    XCTAssertEqual(lastMusic.isStreamable, true)
                } else {
                    XCTFail("This should not happen.")
                }
                
                
            case .failure(let error):
                XCTAssertNotNil(error.localizedDescription)
            }
        })
        
    }
    
    // MARK: - testFetchMusics
    func testFetchMusics() {
                
        viewModel = MusicViewModel(musicRemoteDataSource: MockRemoteDataSourceGetMusics())
        
        viewModel.fetchMusics(term: "jam", completion: { [weak self] result in
            switch result {
                
            case .success:
                
                XCTAssertTrue((self?.viewModel.countOfMusics ?? 0) > 0)
                XCTAssertEqual(self?.viewModel.countOfMusics, 2)

                if let firstMusic = self?.viewModel.musicAt(index: 0) {
                    XCTAssertEqual(firstMusic.artistName, "Michael Jackson")
                    XCTAssertEqual(firstMusic.description, "Michael Jackson's This Is It (The Music That Inspired the Movie)")
                    XCTAssertEqual(firstMusic.trackName, "Jam")
                    XCTAssertEqual(firstMusic.artworkUrl, "https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/2a/82/a5/2a82a59b-6e79-7c39-761a-c1d3b82e93cb/dj.dzbxcmnk.jpg/100x100bb.jpg")
                    XCTAssertEqual(firstMusic.releaseDate, "1987-01-01T12:00:00Z")
                } else {
                    XCTFail("This should not happen.")
                }
                
                if let lastMusic = self?.viewModel.musicAt(index: 1) {
                    XCTAssertEqual(lastMusic.artistName, "Loco & Jam")
                    XCTAssertEqual(lastMusic.description, "Toolroom Ibiza 2015")
                    XCTAssertEqual(lastMusic.trackName, "Oblivion")
                    XCTAssertEqual(lastMusic.artworkUrl, "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/b3/cc/86/b3cc86f2-82a6-1e2b-6a3c-a1da175b7e6e/5052075012674.png/100x100bb.jpg")
                    XCTAssertEqual(lastMusic.releaseDate, "2015-05-04T12:00:00Z")
                } else {
                    XCTFail("This should not happen.")
                }
                
            case .failure:
                XCTFail("This should not happen.")
            }
        })
        
    }

}

// MARK: - Mocks
extension MusicTests {
    
    // MARK: - MockRemoteDataSourceGetMusics
    struct MockRemoteDataSourceGetMusics: MusicRemoteDataSourceProtocol {
        
        
        let musicModel = MusicModel(resultCount: 20, results: [MusicModel.Results(wrapperType: "track",
                                                                                  kind: "song",
                                                                                  artistId: 32940,
                                                                                  collectionId: 336643808,
                                                                                  trackId: 336644171,
                                                                                  artistName: "Michael Jackson",
                                                                                  collectionName: "Michael Jackson's This Is It (The Music That Inspired the Movie)",
                                                                                  trackName: "Jam",
                                                                                  collectionCensoredName: "Michael Jackson's This Is It (The Music That Inspired the Movie)",
                                                                                  trackCensoredName: "Jam",
                                                                                  collectionArtistId: nil,
                                                                                  collectionArtistName: nil,
                                                                                  artistViewUrl: "https://music.apple.com/dk/artist/michael-jackson/32940?uo=4",
                                                                                  collectionViewUrl: "https://music.apple.com/dk/album/jam/336643808?i=336644171&uo=4",
                                                                                  trackViewUrl: "https://music.apple.com/dk/album/jam/336643808?i=336644171&uo=4",
                                                                                  previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/80/90/20/80902024-7d8a-eeb2-b23c-584d1f331ae9/mzaf_12278945373836077860.plus.aac.p.m4a",
                                                                                  artworkUrl30: "https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/2a/82/a5/2a82a59b-6e79-7c39-761a-c1d3b82e93cb/dj.dzbxcmnk.jpg/30x30bb.jpg",
                                                                                  artworkUrl60: "https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/2a/82/a5/2a82a59b-6e79-7c39-761a-c1d3b82e93cb/dj.dzbxcmnk.jpg/60x60bb.jpg",
                                                                                  artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/2a/82/a5/2a82a59b-6e79-7c39-761a-c1d3b82e93cb/dj.dzbxcmnk.jpg/100x100bb.jpg",
                                                                                  collectionPrice: 99,
                                                                                  trackPrice: 10,
                                                                                  releaseDate: "1987-01-01T12:00:00Z",
                                                                                  collectionExplicitness: "notExplicit",
                                                                                  trackExplicitness: "notExplicit",
                                                                                  discCount: 2,
                                                                                  discNumber: 1,
                                                                                  trackCount: 16,
                                                                                  trackNumber: 2,
                                                                                  trackTimeMillis: 338962,
                                                                                  country: "DNK",
                                                                                  currency: "DKK",
                                                                                  primaryGenreName: "Soundtrack",
                                                                                  isStreamable: true),
                                                               MusicModel.Results(wrapperType: "track",
                                                                                  kind: "song",
                                                                                  artistId: 1356487138,
                                                                                  collectionId: 989446960,
                                                                                  trackId: 989447405,
                                                                                  artistName: "Loco & Jam",
                                                                                  collectionName: "Toolroom Ibiza 2015",
                                                                                  trackName: "Oblivion",
                                                                                  collectionCensoredName: "Toolroom Ibiza 2015",
                                                                                  trackCensoredName: "Oblivion",
                                                                                  collectionArtistId: 331122,
                                                                                  collectionArtistName: "Various Artists",
                                                                                  artistViewUrl: "https://music.apple.com/dk/artist/loco/1356487138?uo=4",
                                                                                  collectionViewUrl: "https://music.apple.com/dk/album/oblivion/989446960?i=989447405&uo=4",
                                                                                  trackViewUrl: "https://music.apple.com/dk/album/oblivion/989446960?i=989447405&uo=4",
                                                                                  previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/fc/0c/1a/fc0c1aee-dcb4-4475-e952-8a20b90af21a/mzaf_16891878266679977509.plus.aac.p.m4a",
                                                                                  artworkUrl30: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/b3/cc/86/b3cc86f2-82a6-1e2b-6a3c-a1da175b7e6e/5052075012674.png/30x30bb.jpg",
                                                                                  artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/b3/cc/86/b3cc86f2-82a6-1e2b-6a3c-a1da175b7e6e/5052075012674.png/60x60bb.jpg",
                                                                                  artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/b3/cc/86/b3cc86f2-82a6-1e2b-6a3c-a1da175b7e6e/5052075012674.png/100x100bb.jpg",
                                                                                  collectionPrice: -1,
                                                                                  trackPrice: 10,
                                                                                  releaseDate: "2015-05-04T12:00:00Z",
                                                                                  collectionExplicitness: "notExplicit",
                                                                                  trackExplicitness: "notExplicit",
                                                                                  discCount: 1,
                                                                                  discNumber: 1,
                                                                                  trackCount: 67,
                                                                                  trackNumber: 60,
                                                                                  trackTimeMillis: 398758,
                                                                                  country: "DNK",
                                                                                  currency: "DKK",
                                                                                  primaryGenreName: "Dance",
                                                                                  isStreamable: true)
                                                               
        ])
        
        func fetchMusics(term: String, limit: Int, completion: @escaping (Result<MusicModel, Error>) -> Void) {
            completion(.success(musicModel))
        }
        
        
    }
    
}
