//
//  Plane.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

import UIKit

final class Plane {
    func customizePlane(for plane: UIImageView) {
        plane.image = UIImage(named: "plane")
        plane.layer.shadowOffset = CGSize(width: 7, height: 7)
        plane.layer.shadowOpacity = 0.8
        plane.layer.shadowRadius = 7
        plane.frame = CGRect(x: .screenWidth / 2 - .planeSize / 2, y: .screenHeigth - .planeSize * 2, width: .planeSize, height: .planeSize)
    }
 }
