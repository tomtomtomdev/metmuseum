//
//  ArtRepository.swift
//  Metmuseum
//
//  Created by tomtomtom on 8/11/24.
//
import Combine
import Foundation

protocol ArtRepository {
    func fetchArtworks() -> AnyPublisher<[Artwork], Error>
}

class ArtRepositoryImpl: ArtRepository {
    private let networkService: NetworkService
    private let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1/"

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchArtworks() -> AnyPublisher<[Artwork], Error> {
        guard let url = URL(string: "\(baseURL)search?hasImages=true&q=vanGogh") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return networkService.fetch(url: url)
            .flatMap { (response: SearchResponse) -> AnyPublisher<[Artwork], Error> in
                let ids = response.objectIDs.prefix(10) // Get first 10 artworks
                let artworkPublishers = ids.map { id in
                    self.fetchArtworkDetails(for: id)
                }
                return Publishers.MergeMany(artworkPublishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    private func fetchArtworkDetails(for id: Int) -> AnyPublisher<Artwork, Error> {
        guard let url = URL(string: "\(baseURL)objects/\(id)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return networkService.fetch(url: url)
    }
}

struct SearchResponse: Decodable {
    let objectIDs: [Int]
}
