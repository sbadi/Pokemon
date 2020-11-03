//
//  UIImage+Caching.swift
//  Pokemon
//
//  Created by Alberto Bo on 30/10/2020.
//

import UIKit

protocol ImageCacheType {

    func getCachedImage(for key: NSNumber) -> UIImage?
    func insertImage(_ image: UIImage?, for key: NSNumber)
    func removeImage(for key: NSNumber)
    func removeAllImages()
}


struct CacheConfiguration {
    let countLimit: Int
    let memoryLimit: Int
    static let defaultConfig = CacheConfiguration(countLimit: 1100, memoryLimit: 1024 * 1024 * (AppConstants.pokemonPerPage * 60) * 3) 
}


class ImageCache {

    private lazy var cache: NSCache<NSNumber, UIImage> = {
        let cache = NSCache<NSNumber, UIImage>()
        cache.countLimit = config.countLimit
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()

    private let lock = NSLock()
    private let config: CacheConfiguration

    init(config: CacheConfiguration = CacheConfiguration.defaultConfig) {
        self.config = config
    }
}

extension ImageCache: ImageCacheType {

    func getCachedImage(for key: NSNumber) -> UIImage? {
        self.cache.object(forKey: key)
    }

    func insertImage(_ image: UIImage?, for key: NSNumber) {
        guard let image = image else {
            return removeImage(for: key)
        }
        lock.lock();
        defer { lock.unlock() }
        cache.setObject(image, forKey: key)
    }

    func removeAllImages() {
        lock.lock()
        defer { lock.unlock() }
        self.cache.removeAllObjects()
    }
    func removeImage(for key: NSNumber) {
        lock.lock()
        defer { lock.unlock() }
        self.cache.removeObject(forKey: key)
    }
}
