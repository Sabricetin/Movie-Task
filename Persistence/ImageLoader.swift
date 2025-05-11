//
//  ImageLoader.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 11.05.2025.
//

import Foundation
import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadedImage in
                self?.image = loadedImage
            }
    }

    deinit {
        cancellable?.cancel()
    }
}
