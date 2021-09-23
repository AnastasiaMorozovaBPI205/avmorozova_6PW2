//
//  SettingsViewController.swift
//  avmorozova_6PW2
//
//  Created by Anastasia on 19.09.2021.
//

import UIKit
import CoreLocation

final class SettingsViewController: UIViewController {
    
    private let settingsView = UIStackView()
    private let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
    private let setView = UIView()
    
    var settingColorDelegate: ((UIColor) -> ())?
    var settingLocationDelegate: ((CLLocationCoordinate2D) -> ())?
    var erasingLocationDelegate: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSettingsView()
        setupLocationToggle()
        setupCloseButton()
        setupSliders()
    }
    
    private let sliders = [UISlider(), UISlider(), UISlider()]
    private let colors = ["Red", "Green", "Blue"]
    private func setupSliders() {
        var top = 150
        for i in 0..<sliders.count {
            let view = UIView()
            settingsView.addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.pinLeft(to: settingsView.leadingAnchor, 10)
            view.pinRight(to: settingsView.trailingAnchor, 10)
            view.pinTop(to: settingsView.topAnchor, Double(top))
            
            view.setHeight(to: 30)
            top += 40

            let label = UILabel()
            view.addSubview(label)
            label.text = colors[i]
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.pinTop(to: view.topAnchor, 5)
            label.pinLeft(to: view.leadingAnchor)
            
            label.setWidth(to: 50)

            let slider = sliders[i]
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.addTarget(self,
                             action: #selector(sliderChangedValue),
                             for: .valueChanged)
            view.addSubview(slider)
            
            slider.pinTop(to: view.topAnchor, 5)
            slider.pinLeft(to: label.trailingAnchor, 10)
            slider.pinRight(to: view.trailingAnchor)
            
            slider.setHeight(to: 20)
        }
     }
    
     @objc private func sliderChangedValue() {
        let red: CGFloat = CGFloat(sliders[0].value)
        let green: CGFloat = CGFloat(sliders[1].value)
        let blue: CGFloat = CGFloat(sliders[2].value)
        settingColorDelegate?(UIColor(red: red, green: green, blue: blue, alpha: 1))
     }
    
    private func setupCloseButton() {
        let button = UIButton(type: .close)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.pinRight(to: view.trailingAnchor, 10)
        button.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        
        button.setHeight(to: 30)
        button.widthAnchor.constraint(equalTo:button.heightAnchor).isActive = true
        
        button.addTarget(self, action: #selector(closeScreen),for: .touchUpInside)
     }

     @objc
     private func closeScreen() {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
     }
    
    private func setupSettingsView()
    {
        view.addSubview(setView)
        setView.translatesAutoresizingMaskIntoConstraints = false
        setView.backgroundColor = .systemGray4
        setView.alpha = 1
       
        setView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        setView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 10)
       
        setView.setHeight(to: 510)
        setView.setWidth(to: 300)

        setView.addSubview(settingsView)
        settingsView.axis = .vertical
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        settingsView.pinTop(to: setView.topAnchor)
        settingsView.pinLeft(to: setView.leadingAnchor)
        settingsView.pinRight(to: setView.trailingAnchor)
    }
    
    @objc
     func locationToggleSwitched(_ sender: UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            erasingLocationDelegate?()
            locationManager.stopUpdatingLocation()
        }
     }
    
    private func setupLocationToggle() {
        let locationLabel = UILabel()
        settingsView.addArrangedSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.pinTop(to: settingsView.topAnchor, 10)
        locationLabel.pinLeft(to: settingsView.leadingAnchor, 10)
        
        let locationToggle = UISwitch()
        settingsView.addArrangedSubview(locationToggle)
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        
        locationToggle.pinTop(to: settingsView.topAnchor, 50)
        locationToggle.pinRight(to: settingsView.trailingAnchor, -10)

        locationToggle.addTarget(
            self,
            action: #selector(locationToggleSwitched),
            for: .valueChanged
        )
    }
}

extension SettingsViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate
        else { return }
 
        settingLocationDelegate?(coord)
    }
}
