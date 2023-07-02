//
//  ViewController.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    var centerXPlane: CGFloat!

    //MARK: - UI elements
    private var plane: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.isUserInteractionEnabled = true
        return imageVIew
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        EnemiesVariety(delegate: self).animatedUFO(for: self, enemy: .plane)
        makePanGestureForPlane()
        makeTapGestureForPlane()
    }
    
    //MARK: - private
    
    @objc private func moveThePlane(_ sender: UIPanGestureRecognizer) {
        guard let senderView = sender.view else { return }
        let translation = sender.translation(in: view)
        senderView.center = CGPoint(x: plane.center.x + translation.x,
                                    y: plane.center.y)
        centerXPlane = senderView.center.x
        if centerXPlane < .screenWidth / 8 + .planeSize / 2 || centerXPlane > .screenWidth - .screenWidth / 8 - .planeSize / 2 + .planeStep {
            crashAnimate()
        }
        sender.setTranslation(.zero, in: view)
    }
    
    @objc private func shot() {
        PlaneShot().fire(for: self)
    }
    
    private func makePanGestureForPlane() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveThePlane))
        plane.addGestureRecognizer(panGesture)
    }
    
    private func makeTapGestureForPlane() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(shot))
        plane.addGestureRecognizer(tapGesture)
    }
    
    private func setupVC() {
        view.backgroundColor = .white
        Background().animateBackground(for: self)
        Plane().customizePlane(for: plane)
        centerXPlane = plane.center.x
        view.addSubview(plane)
    }
    
    private func crashAnimate() {
        plane.image = UIImage(named: "explosion")
        if let recognizers = plane.gestureRecognizers {
            for recognizer in recognizers {
                plane.removeGestureRecognizer(recognizer)
            }
        }
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            self.makePanGestureForPlane()
            self.makeTapGestureForPlane()
            self.plane.image = UIImage(named: "plane")
//            self.plane.center.x = .screenWidth / 2
//            self.centerXPlane = self.plane.center.x
        }
    }
}

//MARK: - Delegate extention
extension ViewController: PositionSender {
    func crash(enemyXPosition: CGFloat) {
        let deadRange = enemyXPosition - CGFloat.enemySize...enemyXPosition + CGFloat.enemySize
        if deadRange.contains(centerXPlane){
            crashAnimate()
        }
    }

}
