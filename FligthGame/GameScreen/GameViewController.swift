//
//  ViewController.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {

    var speedRate: Double = 0.8
    var enemySkin: Enemies = .plane
    var userScore = 0
    
    var centerXPlane: CGFloat!
    var lifes = 3 {
        didSet {
            switch lifes {
            case 2:
                lifesLabel.text = "❤ ❤"
            case 1:
                lifesLabel.text = "❤"
            case 0:
                lifesLabel.text = ""
            default:
                lifesLabel.text = "❤ ❤ ❤"
            }
        }
    }
    //MARK: - UI elements
    private var plane: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.isUserInteractionEnabled = true
        return imageVIew
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: .screenWidth / 2 - .scoreAndLifesLabelWidth / 2,
                                          y: .scoreAndLifesYposition,
                                          width: .scoreAndLifesLabelWidth * 1.2,
                                          height: .scoreAndLifesLabelHeight))

        label.text = "Score: 0"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var lifesLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: .screenWidth / 2 + .scoreAndLifesLabelWidth / 1.25,
                                          y: .scoreAndLifesYposition,
                                          width: .scoreAndLifesLabelWidth,
                                          height: .scoreAndLifesLabelHeight))
        switch lifes {
        case 2:
            label.text = "❤ ❤"
        case 1:
            label.text = "❤"
        case 0:
            label.text = ""
        default:
            label.text = "❤ ❤ ❤"
        }
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .red
        
        return label
    }()
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        EnemiesVariety(delegate: self).animatedUFO(for: self, enemy: enemySkin, speedRate: speedRate)
        makePanGestureForPlane()
        makeTapGestureForPlane()
    }
    
    deinit {
        print("Game over")
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
        speedRate = store.gameSettings.speedRate
        enemySkin = store.gameSettings.enemyVariety
        view.backgroundColor = .white
        Background().animateBackground(for: self, speedRate: speedRate)
        Plane().customizePlane(for: plane)
        centerXPlane = plane.center.x
        view.addSubview(plane)
        view.addSubview(scoreLabel)
        view.addSubview(lifesLabel)
    }
    
    private func crashAnimate() {
        guard lifes > 1 else {navigationController?.popViewController(animated: true); saveScore(); return}
        plane.image = UIImage(named: "explosion")
        lifes -= 1
        if let recognizers = plane.gestureRecognizers {
            for recognizer in recognizers {
                plane.removeGestureRecognizer(recognizer)
            }
        }
        print(lifes)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            self.makePanGestureForPlane()
            self.makeTapGestureForPlane()
            self.plane.image = UIImage(named: "plane")
            self.plane.center.x = .screenWidth / 2
            self.centerXPlane = self.plane.center.x
        }
    }
    
    private func saveScore() {
        if userScore > store.usersSettings.last?.score ?? 0 {
            store.usersSettings.last?.score = userScore
            store.saveUsers()
        }
        userScore = 0
    }
}

//MARK: - Delegate extention
extension GameViewController: PositionSenderdelegate {
    func crash(enemyXPosition: CGFloat, enemiesQuantity: Int) {
        let deadRange = enemyXPosition - CGFloat.enemySize...enemyXPosition + CGFloat.enemySize
        if deadRange.contains(centerXPlane){
            crashAnimate()
        }
        userScore = Int(Double(enemiesQuantity) * 10.0 / speedRate)
        scoreLabel.text = "Score: \(userScore)"
    }

}
