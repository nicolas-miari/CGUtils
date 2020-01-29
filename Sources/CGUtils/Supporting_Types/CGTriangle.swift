//
//  CGTriangle.swift
//  CGUtils
//
//  Created by Nicolás Miari on 2019/07/01.
//  Copyright © 2019 Nicolás Miari. All rights reserved.
//

import CoreGraphics

public struct CGTriangle {
    let a: CGPoint
    let b: CGPoint
    let c: CGPoint

    public enum Orientation: Equatable {
        case clockwise
        case counterclockwise
        case colinear
    }

    public var orientation: Orientation {
        let value = (b.y - a.y)*(c.x - b.x) - (b.x - a.x)*(c.y - b.y)
        if value > 0 {
            return .clockwise
        } else if value < 0 {
            return .counterclockwise
        } else {
            return .colinear
        }
    }
}
