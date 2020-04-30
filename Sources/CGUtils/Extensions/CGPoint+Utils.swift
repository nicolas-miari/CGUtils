//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/02/20.
//

import CoreGraphics

// MARK: - Operators

public extension CGPoint {

    // Add two points component-wise
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    // Subtract two poin ts component-wise
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    // Multiply a size by a point (component-wise)
    static func * (scale: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: scale * point.x, y: scale * point.y)
    }

    // Multiply a point by a size (component-wise)
    static func * (point: CGPoint, scale: CGFloat) -> CGPoint {
        return CGPoint(x: scale * point.x, y: scale * point.y)
    }
}

// MARK: - Magnitude Inspection

public extension CGPoint {

    enum Axis {
        case x
        case y
    }

    /**
     The absolute value of the `x` component.
     */
    var xMagnitude: CGFloat {
        return abs(x)
    }

    /**
     The absolute value of the `y` component.
     */
    var yMagnitude: CGFloat {
        return abs(y)
    }

    /**
     The axis with the larger absolute value.
     */
    var predominantAxis: Axis {
        if xMagnitude > yMagnitude {
            return .x
        }
        return .y
    }

    /*
     The largest absolute value component.
     */
    var predominantAxisMagnitude: CGFloat {
        return max(abs(x), abs(y))
    }

    /*
     P.M.W.S.I.T.C.
     */
    var squaredLength: CGFloat {
        return ((x*x) + (y*y))
    }
}

