//
//  CollisionDetection.swift
//  CGUtils
//
//  Created by Nicolás Miari on 2019/07/01.
//  Copyright © 2019 Nicolás Miari. All rights reserved.
//

import Foundation

// MARK: - Procedural Interface

public func distace(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
    let dx = p2.x - p1.x
    let dy = p2.y - p1.y
    return sqrt((dx * dx) + (dy * dy))
}

/**
 Returns the point within `segment` that minimizes distance to `point`.
 */
public func closestPoint(to point: CGPoint, on segment: CGSegment) -> CGPoint {
    let p1 = segment.start
    let p2 = segment.end

    if p2.x == p1.x {
        if p2.y == p1.y {
            // Segment is degenerate; either end point will do:
            return p1
        }
        // Segment is vertical...

        // => All points on the segment (intersection included) have the same x value:
        let ix = p1.x

        // => Line perpendicular to the segment is Horizontal
        // => all points on it (outside point included) have the same y value:
        let iy = point.y

        /*
         Calculate parameter value of the intersection point, relative to segment
         endpoints. If the segment's parametrci equation is:
         y = p1.y + t*(p2.y - p1.y)

         Then:
         t = (point.y - p1.y)/(p2.y - p1.y)
         */
        let t = (point.y - p1.y)/(p2.y - p1.y)

        if t < 0 {
            // Intersection lies outside th segment, on the side of p1; closest
            // point ON THE SEGMENT is therefore p1:
            return p1
        } else if t > 1 {
            // Intersection lies outside th segment, on the side of p2; closest
            // point ON THE SEGMENT is therefore p2:
            return p2
        } else {
            // Intersection lies within the segment; it is therefore the closest
            // point:
            return CGPoint(x: ix, y: iy)
        }
    } else {
        // Segment is non-vertical; calulate slope:
        let m1 = (p2.y - p1.y)/(p2.x - p1.x)

        // ...and constant term:
        let b1 = p2.y - m1*(p2.x)

        // The normal passes through self and has slope negative inverse;
        // calculate its constant term:
        let m2 = (-1/m1)
        let b2 = point.y - m2*(point.x)

        /*
         Calculate the intersection of both lines:
         m1*x + b1 = m2*x + b2
         => m1*x - m2*x = b2 - b1
         => (m1 - m2)*x = b2 - b1
         => x = (b2 - b1)/(m1 - m2)
         */
        let ix = (b2 - b1)/(m1 - m2)
        let iy = m1*ix + b1

        /*
         Parametric equation of the line containing segment:
         p1.x + t*(p2.x - p1.x) = ix

         => Parameter value at the intersection point:
         t = (ix - p1.x)/(p2.x - p1.x)
         */
        let t = (ix - p1.x)/(p2.x - p1.x)

        if t < 0 {
            // Intersection lies outside th segment, on the side of p1; closest
            // point ON THE SEGMENT is therefore p1:
            return p1
        } else if t > 1 {
            // Intersection lies outside th segment, on the side of p2; closest
            // point ON THE SEGMENT is therefore p2:
            return p2
        } else {
            // Intersection lies within the segment; it is therefore the closest
            // point:
            return CGPoint(x: ix, y: iy)
        }
    }
}

/**
 Returns the minimum distance between `point` and any point contained within
 `segment`.

 - note: Internally calls `closestPoint(to:on:)` and then returns the distance between
 both points.
 */
public func distance(between point: CGPoint, and segment: CGSegment) -> CGFloat {
    let pointOnSegment = closestPoint(to: point, on: segment)
    return distace(from: point, to: pointOnSegment)
}

/**
 Returns `true` if both segments intersect (includes 'touching' at one point).
 */
public func segment(_ segment1: CGSegment, intersects segment2: CGSegment) -> Bool {
    let p1 = segment1.start
    let p2 = segment1.end

    let q1 = segment2.start
    let q2 = segment2.end

    /*
     1. Compare orientations of the two triangles spanned by the segment 1
     when paired with each point of segment 2.
     If both non-degenerate triangles have the same orientation, intersection is
     impossible. A degenerate triangle, on the other hand, indicates contact at
     one point.
     */
    let orientation1 = CGTriangle(a: p1, b: p2, c: q1).orientation
    let orientation2 = CGTriangle(a: p1, b: p2, c: q2).orientation

    if orientation1 == .colinear || orientation2 == .colinear {
        return true
    }
    if orientation1 == orientation2 {
        // No intersection possible
        return false
    }

    /*
     2. Compare orientations of the two triangles spanned by the segment 2
     when paired with each point of segment 1.
     If both non-degenerate triangles have the same orientation, intersection is
     impossible. A degenerate triangle, on the other hand, indicates contact at
     one point.
     */
    let orientation3 = CGTriangle(a: q1, b: q2, c: p1).orientation
    let orientation4 = CGTriangle(a: q1, b: q2, c: p2).orientation

    if orientation3 == .colinear || orientation4 == .colinear {
        return true
    }
    if orientation3 == orientation4 {
        // No intersection possible
        return false
    }
    return true
}

// MARK: - Object-Oriented Interface

public extension CGSegment {
    func distance(to point: CGPoint) -> CGFloat {
        return CGUtils.distance(between: point, and: self)
    }

    func intersects(_ otherSegment: CGSegment) -> Bool {
        return segment(self, intersects: otherSegment)
    }
}

public extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return distace(from: self, to: point)
    }

    func distance(to segment: CGSegment) -> CGFloat {
        let point = closestPoint(to: self, on: segment)
        return distance(to: point)
    }
}
