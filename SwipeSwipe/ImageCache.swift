//
//  ImageCache.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 16/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

class ImageChache: NSObject {

    static let shared = ImageChache()
    
    private(set) var cache: NSCache<AnyObject, AnyObject> = NSCache()
    
    func getImageFromCache(key: String) -> UIImage? {
        if (self.cache.object(forKey: key as AnyObject) != nil) {
            return self.cache.object(forKey: key as AnyObject) as? UIImage
        } else {
            return nil
        }
    }
    
    func saveImageToCache(key: String, image: UIImage) {
        self.cache.setObject(image, forKey: key as AnyObject)
    }
    
}
