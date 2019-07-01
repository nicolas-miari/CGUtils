//
//  CGSegment.swift
//  CGUtils
//
//  Created by Nicolás Miari on 2019/07/01.
//  Copyright © 2019 Nicolás Miari. All rights reserved.
//

import CoreGraphics

public struct CGSegment {
    let start: CGPoint
    let end: CGPoint

    public init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
    }
}
