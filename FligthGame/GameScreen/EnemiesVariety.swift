//
//  UFO.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

protocol PositionSenderdelegate: AnyObject{
    func crash(enemyXPosition: CGFloat)
}

import UIKit
enum Enemies {
    case ufo
    case plane
}

class EnemiesVariety {
    
    weak var delegate: PositionSenderdelegate?
    var ufoXposition: CGFloat? {
        didSet {
            self.delegate?.crash(enemyXPosition: ufoXposition ?? 0)
        }
    }
    
    init(delegate: PositionSenderdelegate) {
        self.delegate = delegate
    }
    
    func animatedUFO(for viewController: UIViewController, enemy: Enemies) {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            let ufo = UIImageView()
            switch enemy {
            case .ufo:
                ufo.image = UIImage(named: "ufo")
            case .plane:
                ufo.image = UIImage(named: "enemyPlane")
            }
            ufo.layer.shadowOffset = CGSize(width: 5, height: 5)
            ufo.layer.shadowOpacity = 0.7
            ufo.layer.shadowRadius = 5
            ufo.frame = CGRect(x: CGFloat.random(in: CGFloat.screenWidth / 8...CGFloat.screenWidth - CGFloat.screenWidth / 8 - .enemySize  ), y: .enemyStart, width: .enemySize, height: .enemySize)
            viewController.view.addSubview(ufo)
            let timeX = 5 * (CGFloat.planeYPosition / CGFloat.enemyTrip)
            let timeY = 5 * ((CGFloat.planeYPosition + .planeSize) / CGFloat.enemyTrip)
            DispatchQueue.main.asyncAfter(deadline: .now() + timeX) {
                self.ufoXposition = ufo.layer.presentation()?.frame.midX ?? 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + timeY) {
                self.ufoXposition = 0
            }
            UIView.animate(withDuration: 5, delay: 0, options: .curveLinear) {
                ufo.frame.origin.y = .screenHeigth
            } completion: { _ in
                ufo.removeFromSuperview()
            }
        }
    }
}
