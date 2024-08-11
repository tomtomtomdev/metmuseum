//
//  ArtworkRowView.swift
//  Metmuseum
//
//  Created by tomtomtom on 8/11/24.
//

import Foundation
import SwiftUI

struct ArtworkRowView: View {
    let artwork: Artwork
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(artwork.title)
                .font(.headline)
            Text(artwork.artist)
                .font(.subheadline)
            
            if let imageURL = artwork.imageURL {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image.resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                    
                }
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            }
        }
    }
}
