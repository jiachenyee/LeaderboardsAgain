//
//  Room.swift
//  Leaderboards
//
//  Created by JiaChen(: on 3/11/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import Foundation

struct Room {
    var name: String
    var editors: [String] // Email of editors
    var domains: [String]
    var code: String
    var groups: [(name: String, points: Int)]
    var upperBound: Int
}
