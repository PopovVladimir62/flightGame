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
        return imageVIew
    }()
    
    private var leftButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var rightButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var fireButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupButtons()
        EnemiesVariety(delegate: self).animatedUFO(for: self, enemy: .plane)
    }
    
    //MARK: - private
    @objc private func actionPlane(_ sender: UIButton) {
        switch sender {
        case leftButton:
            if centerXPlane < .screenWidth / 8 + .planeSize / 2{
                crashAnimate()
                return
            }
            centerXPlane -= .planeStep
            updatePlaneXPosition()
        case rightButton:
            if centerXPlane > .screenWidth - .screenWidth / 8 - .planeSize / 2 + .planeStep {
                crashAnimate()
                return
            }
            centerXPlane += .planeStep
            updatePlaneXPosition()
        case fireButton:
            PlaneShot().fire(for: self)
        default:
            break
        }
    }
    
    private func setupVC() {
        view.backgroundColor = .white
        Background().animateBackground(for: self)
        Plane().customizePlane(for: plane)
        centerXPlane = plane.center.x
        view.addSubview(plane)
    }
    
    private func setupButtons() {
        leftButton.frame = CGRect(x: .screenWidth/8, y: .screenHeigth - .buttonSize * 1.5, width: .buttonSize, height: .buttonSize)
        leftButton.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        leftButton.tintColor = .systemGray
        leftButton.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        leftButton.addTarget(self, action: #selector(actionPlane), for: .touchUpInside)
        view.addSubview(leftButton)
        
        rightButton.frame = CGRect(x: .screenWidth - .screenWidth/8 - .buttonSize, y: .screenHeigth - .buttonSize * 1.5, width: .buttonSize, height: .buttonSize)
        rightButton.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
        rightButton.tintColor = .systemGray
        rightButton.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        rightButton.addTarget(self, action: #selector(actionPlane), for: .touchUpInside)
        view.addSubview(rightButton)
        
        fireButton.frame = CGRect(x: .screenWidth - .buttonSize, y: .screenHeigth - .buttonSize * 2.5, width: .buttonSize, height: .buttonSize)
        fireButton.setImage(UIImage(systemName: "flame.circle.fill"), for: .normal)
        fireButton.tintColor = .systemRed
        fireButton.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        fireButton.addTarget(self, action: #selector(actionPlane), for: .touchUpInside)
        view.addSubview(fireButton)
    }
    
    private func crashAnimate() {
        leftButton.isEnabled = false
        rightButton.isEnabled = false
        plane.image = UIImage(named: "explosion")
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            self.plane.image = UIImage(named: "plane")
            self.leftButton.isEnabled = true
            self.rightButton.isEnabled = true
            self.plane.center.x = .screenWidth / 2
            self.centerXPlane = self.plane.center.x
        }
    }
    
    private func updatePlaneXPosition() {
        UIView.animate(withDuration: 0.3) {
            self.plane.center.x = self.centerXPlane
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
