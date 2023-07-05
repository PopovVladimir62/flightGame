//
//  MainViewController.swift
//  FligthGame
//
//  Created by Владимир on 05.07.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - UI elements
    private lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = .mainButtonHeight / 2
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: .mainButtonHeight / 2)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = .mainButtonHeight / 2
        button.setTitle("Settings", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: .mainButtonHeight / 2)
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupLayout()
    }
    
    //MARK: - selectors
    @objc private func startGame() {
        let game = GameViewController()
        navigationController?.pushViewController(game, animated: false)
    }
    
    @objc private func openSettings() {
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
    }
    
    //MARK: - private
    private func setupVC() {
        view.backgroundColor = .white
        view.addSubview(startGameButton)
        view.addSubview(settingsButton)
    }
    
    //MARK: - layout
    private func setupLayout() {
        startGameButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.mainButtonWidth)
            make.height.equalTo(CGFloat.mainButtonHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat.mainButtonHeight * 3)
        }
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.mainButtonWidth)
            make.height.equalTo(CGFloat.mainButtonHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat.mainButtonHeight * 4.5)
        }
    }
}
