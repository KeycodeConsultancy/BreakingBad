//
//  Details.swift
//  BreakingBad
//
//  Created by Kevin Reid on 10/12/2020.
//

import Foundation


struct Details: Codable {
    var char_id: Int
    let img: String
    let name: String
    let occupation: [String]
    let status: String
    let nickname: String
    //let appearance: [Int] // does not work
}



