//
//  ArtViewModel.swift
//  Metmuseum
//
//  Created by tomtomtom on 8/11/24.
//

import Combine
import Foundation

class ArtViewModel: ObservableObject {
    @Published var artworks: [Artwork] = []
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()
    private let artRepository: ArtRepository

    init(artRepository: ArtRepository) {
        self.artRepository = artRepository
    }

    func fetchArtworks() {
        artRepository.fetchArtworks()
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            }, receiveValue: { [weak self] artworks in
                self?.artworks = artworks
            })
            .store(in: &cancellables)
    }
}
