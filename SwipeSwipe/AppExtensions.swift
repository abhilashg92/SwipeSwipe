//
//  AppExtensions.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 17/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

extension String {
    func showDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateObj = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        print("Dateobj: \(dateFormatter.string(from: dateObj!))")
        return "\(dateFormatter.string(from: dateObj!))"
    }
}

extension UIView {
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

}
