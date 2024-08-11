//
//  Artwork.swift
//  Metmuseum
//
//  Created by tomtomtom on 8/11/24.
//
import Foundation

struct Artwork: Decodable, Identifiable {
    let id: Int
    let title: String
    let artist: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case title
        case artist = "artistDisplayName"
        case imageURL = "primaryImageSmall"
    }
}
