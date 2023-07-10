//
//  User.swift
//  FligthGame
//
//  Created by Владимир on 06.07.2023.
//

import Foundation

final public class User: Codable {
    var name: String
    var avatarID: String?
    var score = 0
    
    init(name: String) {
        self.name = name
    }
}
