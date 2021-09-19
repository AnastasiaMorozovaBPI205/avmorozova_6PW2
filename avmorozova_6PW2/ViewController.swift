//
//  ViewController.swift
//  avmorozova_6PW2
//
//  Created by Anastasia on 19.09.2021.
//

import UIKit

class ViewController: UIViewController {

    private let settingsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSettingsView()
        setupSettingsButton()
    }
    
    @objc
     private func settingsButtonPressed() {
     UIView.animate(withDuration: 0.1, animations: {
     self.settingsView.alpha = 1 - self.settingsView.alpha
     })
     }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
     return .lightContent
     }
    
    private func setupSettingsView()
    {
        settingsView.backgroundColor = .blue
        view.addSubview(settingsView)
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        settingsView.topAnchor.constraint(
         equalTo: view.safeAreaLayoutGuide.topAnchor,
         constant: 10
         ).isActive = true
        
        settingsView.trailingAnchor.constraint(
         equalTo: view.safeAreaLayoutGuide.trailingAnchor,
         constant: -10
         ).isActive = true
        
        settingsView.heightAnchor.constraint(
            equalToConstant: 300
        ).isActive = true
        
        settingsView.widthAnchor.constraint(
            equalToConstant: 200
        ).isActive = true
        
        settingsView.alpha = 0
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
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),
        for: .touchUpInside)
    }


}

