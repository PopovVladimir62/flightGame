//
//  Background.swift
//  FligthGame
//
//  Created by Владимир on 17.06.2023.
//

import UIKit

final class Background {
    
    func animateBackground(for viewController: UIViewController)
    {
        let backgroundImage = UIImage(named:"reaver")!

        // UIImageView 1
        let backgroundImageView1 = UIImageView(image: backgroundImage)
        backgroundImageView1.frame = CGRect(x: 0, y: 0, width: .screenWidth, height: .screenHeigth)
        backgroundImageView1.contentMode = .scaleToFill
        viewController.view.addSubview(backgroundImageView1)

        // UIImageView 2
        let backgroundImageView2 = UIImageView(image: backgroundImage)
        backgroundImageView2.frame = CGRect(x: 0, y: -.screenHeigth, width: .screenWidth, height: .screenHeigth)
        backgroundImageView2.contentMode = .scaleToFill
        viewController.view.addSubview(backgroundImageView2)

        // Animate background
        UIView.animate(withDuration: 6.0, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            backgroundImageView1.frame = backgroundImageView1.frame.offsetBy(dx: 0.0, dy: backgroundImageView1.frame.size.height)
            backgroundImageView2.frame = backgroundImageView2.frame.offsetBy(dx: 0.0, dy: backgroundImageView1.frame.size.height)
            }, completion: nil)
    }
}
