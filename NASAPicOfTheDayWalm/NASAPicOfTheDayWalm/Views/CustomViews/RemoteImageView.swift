//
//  RemoteImageView.swift
//  NASAPicOfTheDayWalm
//
//  Created by Harish Sami on 21/08/24.
//

import SwiftUI

struct RemoteImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView()
                .onAppear {
                    imageLoader.loadImage(from: urlString)
                }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
