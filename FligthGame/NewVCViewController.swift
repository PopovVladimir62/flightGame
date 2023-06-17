

import UIKit

// MARK: - Constants

private enum Constant {
    static let circleSize: CGFloat = 100
    static let circleRadius: CGFloat = circleSize/2
    static let offset: CGFloat = 20
}

class NEWViewController: UIViewController {
    
    private var circleView: UIView!
    private var circleCenter: CGPoint!
    private var buttonFrames: [CGRect] = []

    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupCircleView()
    }
    
    // MARK: - WASD buttons
    func setupButtons() {
        let buttonSize = CGSize(width: 60, height: 60)
        let buttonSpacing: CGFloat = 20
        let buttonOriginY = view.bounds.height - buttonSize.height - buttonSpacing
        
        let upButton = createButton(title: "⬆️", frame: CGRect(origin: CGPoint(x: view.bounds.width/2 - buttonSize.width/2, y: buttonOriginY - buttonSize.height - buttonSpacing), size: buttonSize))
        let leftButton = createButton(title: "⬅️", frame: CGRect(origin: CGPoint(x: upButton.frame.minX - buttonSize.width - buttonSpacing, y: buttonOriginY), size: buttonSize))
        let downButton = createButton(title: "⬇️", frame: CGRect(origin: CGPoint(x: upButton.frame.minX, y: buttonOriginY), size: buttonSize))
        let rightButton = createButton(title: "➡️", frame: CGRect(origin: CGPoint(x: upButton.frame.maxX + buttonSpacing, y: buttonOriginY), size: buttonSize))
        
        buttonFrames = [upButton.frame, leftButton.frame, downButton.frame, rightButton.frame]
        
        rightButton.addTarget(self, action: #selector(moveCircleRight), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(moveCircleDown), for: .touchUpInside)
        upButton.addTarget(self, action: #selector(moveCircleUp), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(moveCircleLeft), for: .touchUpInside)
        
        view.addSubview(upButton)
        view.addSubview(leftButton)
        view.addSubview(downButton)
        view.addSubview(rightButton)
    }
    
    func createButton(title: String, frame: CGRect) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.341, green: 0.624, blue: 0.168, alpha: 0.3)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }
    
    // MARK: - Constants
    func setupCircleView() {
        let circleFrame = CGRect(
            x: view.bounds.midX - Constant.circleRadius,
            y: view.bounds.midY - Constant.circleRadius,
            width: Constant.circleSize,
            height: Constant.circleSize
        )
        
        circleView = UIView(frame: circleFrame)
        circleView.backgroundColor = .red
        circleView.layer.cornerRadius = Constant.circleRadius
        view.addSubview(circleView)
        circleCenter = circleView.center
    }

    @objc func moveCircleUp() {
        let newCenter = CGPoint(x: circleCenter.x, y: circleCenter.y - Constant.offset)
        if circleCanMove(to: newCenter) {
            circleCenter = newCenter
            updateCircleViewPosition()
        }
    }

    @objc func moveCircleLeft() {
        let newCenter = CGPoint(x: circleCenter.x - Constant.offset, y: circleCenter.y)
        if circleCanMove(to: newCenter) {
            circleCenter = newCenter
            updateCircleViewPosition()
        }
    }

    @objc func moveCircleDown() {
        let newCenter = CGPoint(x: circleCenter.x, y: circleCenter.y + Constant.offset)
        if circleCanMove(to: newCenter) {
            circleCenter = newCenter
            updateCircleViewPosition()
        }
    }

    @objc func moveCircleRight() {
        let newCenter = CGPoint(x: circleCenter.x + Constant.offset, y: circleCenter.y)
        if circleCanMove(to: newCenter) {
            circleCenter = newCenter
            updateCircleViewPosition()
        }
    }

    func circleCanMove(to newCenter: CGPoint) -> Bool {
        let newCircleFrame = CGRect(
            origin: CGPoint(x: newCenter.x - Constant.circleRadius, y: newCenter.y - Constant.circleRadius),
            size: CGSize(width: Constant.circleSize, height: Constant.circleSize)
        )
        
        for buttonFrame in buttonFrames {
            if newCircleFrame.intersects(buttonFrame) {
                return false
            }
        }
        
        let viewBounds = view.safeAreaLayoutGuide.layoutFrame
        
        if !viewBounds.contains(newCircleFrame) {
            return false
        }
        
        return true
    }

    func updateCircleViewPosition() {
        UIView.animate(withDuration: 0.2) {
            self.circleView.center = self.circleCenter
        }
    }
}




 

