//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/02/20.
//

import CoreGraphics

public extension CGPoint {

    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func * (scale: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: scale * point.x, y: scale * point.y)
    }

    static func * (point: CGPoint, scale: CGFloat) -> CGPoint {
        return scale * point
    }
}
