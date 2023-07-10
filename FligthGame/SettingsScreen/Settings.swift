//
//  Settings.swift
//  FligthGame
//
//  Created by Владимир on 05.07.2023.
//

import Foundation

final public class Settings: Codable {
    var speedRate: Double
    var enemyVariety: Enemies
    
    init(speedRate: Double, enemyVariety: Enemies) {
        self.speedRate = speedRate
        self.enemyVariety = enemyVariety
    }
}
