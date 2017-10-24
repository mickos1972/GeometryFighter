//
//  ShapeType.swift
//  GeometryFighter
//
//  Created by mick murphy on 24/10/2017.
//  Copyright © 2017 Mick M. All rights reserved.
//

import Foundation
// 1
enum ShapeType:Int
{
    case box = 0
    case sphere
    case pyramid
    case torus
    case capsule
    case cylinder
    case cone
    case tube
    // 2
    static func random() -> ShapeType
    {
        let maxValue = tube.rawValue
        let rand = arc4random_uniform(UInt32(maxValue+1))
        return ShapeType(rawValue: Int(rand))!
    }
}
