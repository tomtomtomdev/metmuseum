//
//  ContentView.swift
//  Metmuseum
//
//  Created by tomtomtom on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArtViewModel(artRepository: ArtRepositoryImpl(networkService: NetworkServiceImpl()))
    @State var isPresented = false
    @State private var selectedArtwork: Artwork?

    var body: some View {
        NavigationView {
            List(viewModel.artworks) { artwork in
                Button(action: {
                    selectedArtwork = artwork
                }) {
                    VStack(alignment: .leading) {
                        Text(artwork.title)
                            .font(.headline)
                        Text(artwork.artist)
                            .font(.subheadline)
                        
                        if let imageURL = artwork.imageURL {
                            AsyncImage(url: URL(string: imageURL))
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .sheet(item: $selectedArtwork, content: { artwork in
                ArtworkDetailView(artwork: artwork)
            })
            .navigationTitle("Met Artworks")
            .onAppear {
                viewModel.fetchArtworks()
            }
            .alert("Text", isPresented: $isPresented) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}
