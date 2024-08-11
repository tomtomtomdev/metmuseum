//
//  ArtworkDetailView.swift
//  Metmuseum
//
//  Created by tomtomtom on 8/11/24.
//

import SwiftUI

struct ArtworkDetailView: View {
    let artwork: Artwork

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let imageURL = artwork.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
            } else {
                Text("No image available")
                    .font(.headline)
            }

            Text(artwork.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Artist: \(artwork.artist.isEmpty ? "Unknown" : artwork.artist)")
                .font(.title2)

            Spacer()
        }
        .padding()
        .navigationTitle("Artwork Details")
    }
}
