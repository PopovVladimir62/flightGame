//
//  CGFloat + Ext.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

import UIKit

extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeigth = UIScreen.main.bounds.height
    static let planeStep: CGFloat = 15
    static let planeSize: CGFloat = 60
    static let planeYPosition = .screenHeigth - .planeSize * 2
    static let buttonSize: CGFloat = 50
    static let ufoSize: CGFloat = 50
    static let ufoStart: CGFloat = -ufoSize
    static let ufoTrip = screenHeigth + ufoSize
}
