//
//  ViewController.swift
//  avmorozova_6PW2
//
//  Created by Anastasia on 19.09.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSettingsButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
     return .lightContent
     }
    
    private func setupSettingsButton()
    {
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "setting_logo"), for: .normal)
        
        view.addSubview(settingsButton)
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingsButton.topAnchor.constraint(
         equalTo: view.safeAreaLayoutGuide.topAnchor,
         constant: 15
         ).isActive = true
        
        settingsButton.trailingAnchor.constraint(
         equalTo: view.safeAreaLayoutGuide.trailingAnchor,
         constant: -15
         ).isActive = true
        
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive
        = true
         settingsButton.widthAnchor.constraint(equalTo:
        settingsButton.heightAnchor).isActive = true
    }


}

