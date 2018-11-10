//
//  CustomView.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    
//    override var directionalLayoutMargins: NSDirectionalEdgeInsets {
//        return NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
//    }
    
    @IBInspectable var height: CGFloat = 1 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 1, height: self.height)
    }
    
}
