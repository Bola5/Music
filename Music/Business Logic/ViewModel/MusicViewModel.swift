//
//  MusicViewModel.swift
//  Music
//
//  Created by Bola Fayez on 18/04/2023.
//

import Foundation

protocol MusicViewModelProtocol {
    
    //MARK: - Protocol - Data Source
    var countOfMusics: Int { get }
    var isLastPage: Bool { get }
    func musicAt(index: Int) -> MusicLayoutViewModel.ResultsLayoutViewModel?
    func shouldFetchNextPage(index: Int) -> Bool
    
    // MARK: - Protocol - fetch
    func fetchMusics(term: String, completion: @escaping MusicViewModel.GetMusicCompletionBlock)
}

class MusicViewModel: MusicViewModelProtocol {

    // MARK: - Callback type alias
    typealias GetMusicCompletionBlock = (Result<Bool, Error>) -> Void

    // MARK: - Properties
    private var limit: Int = 20
    private var nextPage: Int = 1
    // Data Source
    private let musicRemoteDataSource: MusicRemoteDataSourceProtocol
    private var layoutViewModel: MusicLayoutViewModel?
    var countOfMusics: Int {
        return layoutViewModel?.results.count ?? 0
    }
    var isLastPage: Bool {
        return countOfMusics == 200
    }
    
    // Init
    init(musicRemoteDataSource: MusicRemoteDataSourceProtocol = MusicRemoteDataSource()) {
        
        self.musicRemoteDataSource = musicRemoteDataSource
    }
    
}

// MARK: - Protocol - Data Source method
extension MusicViewModel {
    
    func musicAt(index: Int) -> MusicLayoutViewModel.ResultsLayoutViewModel? {
        return self.layoutViewModel?.results[index]
    }
    
    func shouldFetchNextPage(index: Int) -> Bool {
        return index == countOfMusics - 4
    }

}

// MARK: - Protocol - fetch
extension MusicViewModel {
    
    func fetchMusics(term: String, completion: @escaping GetMusicCompletionBlock) {
        musicRemoteDataSource.fetchMusics(term: term, limit: limit, completion: { [weak self] result in
            switch result {
            case .success(let musicModel):
                self?.nextPage += 1
                self?.updateLimit()
                self?.layoutViewModel = MusicLayoutViewModel(musics: musicModel)
                completion(.success(true))
            case .failure(let error):
                if (self?.nextPage ?? 0) >= 2 {
                    self?.nextPage -= 1
                    self?.limit -= (self?.limit ?? 0)
                }
                completion(.failure(error))
            }
        })
    }

    private func updateLimit() {
        limit += 20
    }
    
}
