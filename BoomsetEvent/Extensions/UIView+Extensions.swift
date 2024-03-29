//
//  UIView+Extensions.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat = 8, borderColor: UIColor = .gray, borderWidth: CGFloat = 0) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}
