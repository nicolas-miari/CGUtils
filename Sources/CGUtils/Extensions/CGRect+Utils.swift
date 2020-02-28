//
//  CGRect.swift
//  
//
//  Created by Nicolás Miari on 2020/02/20.
//

import CoreGraphics

public extension CGRect {

    // MARK: - Multiply origin and size by a scalar

    static func * (scale: CGFloat, rect: CGRect) -> CGRect {
        let origin = scale * rect.origin
        let size = scale * rect.size
        return CGRect(origin: origin, size: size)
    }

    static func * (rect: CGRect, scale: CGFloat) -> CGRect {
        return scale * rect
    }

    // MARK: - Multiply origin and size by a size (component-wise)

    static func * (size: CGSize, rect: CGRect) -> CGRect {
        let origin = size * rect.origin
        let size = scale * rect.size
        return CGRect(origin: origin, size: size)
    }

    static func * (rect: CGRect, size: CGSize) -> CGRect {
        return size * rect
    }

    // MARK: - Divide origin and size by a size (component-wise)

    static func / (rect: CGRect, size: CGSize) -> CGRect {
        let invSize = CGSize(width: 1/size.width, height: 1/size.height)
        return invSize * rect
    }

    // MARK: - Other

    /**
     Convenience wrapper around `offsetBy(dx:dy:)` that takes a **single** argument, of type `CGVector`.
     */
    func offsetBy(_ vector: CGVector) -> CGRect {
        return self.offsetBy(dx: vector.dx, dy: vector.dy)
    }

    /**
     Creates and instance as the smallest axis-aligned rectangle that contains the two specified points.
     */
    init(spannedBy point1: CGPoint, and point2: CGPoint) {
        let x = min(point1.x, point2.x)
        let y = min(point1.y, point2.y)
        let width = abs(point1.x - point2.x)
        let height = abs(point1.y - point2.y)

        self.init(x: x, y: y, width: width, height: height)
     }
}
