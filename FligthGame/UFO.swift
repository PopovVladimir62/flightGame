//
//  UFO.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

import UIKit

class UFO {
    func animatedUFO(for viewController: UIViewController) {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            let ufo = UIImageView(image: UIImage(named: "ufo"))
            ufo.frame = CGRect(x: CGFloat.random(in: CGFloat.screenWidth / 8...CGFloat.screenWidth - CGFloat.screenWidth / 8  ), y: .ufoStart, width: .ufoSize, height: .ufoSize)
            viewController.view.addSubview(ufo)
            UIView.animate(withDuration: 5, delay: 0, options: .curveLinear) {
                ufo.frame.origin.y = .screenHeigth
            } completion: { _ in
                ufo.removeFromSuperview()
            }
        }
    }
}
