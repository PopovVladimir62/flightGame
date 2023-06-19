//
//  PlaneShot.swift
//  FligthGame
//
//  Created by Владимир on 18.06.2023.
//

import UIKit

final class PlaneShot {
    func fire(for viewController: ViewController) {
        let shot = UIImageView(frame: CGRect(x: viewController.centerXPlane, y: .screenHeigth - .planeSize * 2, width: .shotSize, height: .shotSize))
        shot.backgroundColor = .red
        shot.layer.cornerRadius = .shotSize / 2
        viewController.view.addSubview(shot)
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            shot.frame.origin.y = 0
        } completion: { Bool in
            shot.removeFromSuperview()
        }
    }
}
