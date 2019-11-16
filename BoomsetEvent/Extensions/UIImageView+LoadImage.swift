//
//  UIImageView+LoadImage.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    /// if we want to user Kingfiser or anytign else in place of the SDWemImage library for async loading image from url only we can change this function
    func loadProfileImageWith(url: String, placeholder: UIImage? = UIImage(named: "profile")) {
        self.sd_setImage(with: URL(string: url), placeholderImage: placeholder)
    }
}
