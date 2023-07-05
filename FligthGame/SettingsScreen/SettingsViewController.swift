//
//  SettingsViewController.swift
//  FligthGame
//
//  Created by Владимир on 05.07.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    deinit {
        print("settings VC is dead")
    }
    
    //MARK: - private
    private func setupVC() {
        view.backgroundColor = .systemGray4
    }
}
