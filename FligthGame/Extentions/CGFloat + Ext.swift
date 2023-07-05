//
//  CGFloat + Ext.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

import UIKit

extension CGFloat {
    //GameViewController values
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeigth = UIScreen.main.bounds.height
    static let planeStep: CGFloat = 15
    static let planeSize: CGFloat = 60
    static let planeYPosition = .screenHeigth - .planeSize * 2
    static let buttonSize: CGFloat = 50
    static let enemySize: CGFloat = 50
    static let enemyStart: CGFloat = -enemySize
    static let enemyTrip = screenHeigth + enemySize
    static let shotSize: CGFloat = 8
    static let scoreAndLifesYposition: CGFloat = 50
    static let scoreAndLifesLabelWidth: CGFloat = 100
    static let scoreAndLifesLabelHeight: CGFloat = 20
    //MainViewController values
    static let mainButtonHeight = screenHeigth / 12
    static let mainButtonWidth = screenWidth / 2
    
}
