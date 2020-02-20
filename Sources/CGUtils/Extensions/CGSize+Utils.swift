//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/02/20.
//

import CoreGraphics

public extension CGSize {

    /**
     Convenience shortcut for `width` divided by `height`
     */
    var aspectRatio: CGFloat {
        return width / height
    }

    /**
     Returns a size with the same `width` and `height` components, but **swapped** (i.e., "rotated 90 degrees").
     */
    var flipped: CGSize {
        return CGSize(width: height, height: width)
    }

    static func * (scale: CGFloat, size: CGSize) -> CGSize {
        return CGSize(width: scale * size.width, height: scale * size.height)
    }

    static func * (size: CGSize, scale: CGFloat) -> CGSize {
        return scale * size
    }

    static func / (size: CGSize, fraction: CGFloat) -> CGSize {
        return CGSize(width: size.width / fraction, height: size.height / fraction)
    }
}

