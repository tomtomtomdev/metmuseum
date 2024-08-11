//
//  NetworkService.swift
//  Metmuseum
//
//  Created by tomtomtom on 8/11/24.
//
import Foundation
import Combine

protocol NetworkService {
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error>
}

class NetworkServiceImpl: NetworkService {
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
