//
//  ViewController.swift
//  avmorozova_6PW2
//
//  Created by Anastasia on 19.09.2021.
//

import UIKit
import CoreLocation

protocol SettingsDataPass{
    func changeBackgroundColor(color: UIColor) -> ()
    func printLocation(coord: CLLocationCoordinate2D) -> ()
    func eraseLocation() -> ()
}

class ViewController: UIViewController {

    private let settingsView = UIStackView()
    private let setView = UIView()
    private let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupLocationTextView()
        setupSettingsView()
        setupSettingsButton()
        setupLocationToggle()
        setupSliders()
    }
    
    private var buttonCount = 0
     @objc private func settingsButtonPressed() {
        switch buttonCount {
            case 0, 1:
                UIView.animate(
                    withDuration: 0.1,
                    animations: { self.setView.alpha = 1 - self.setView.alpha})
            case 2:
                let settingsViewController = SettingsViewController()
                settingsViewController.settingColorDelegate = changeBackgroundColor
                settingsViewController.settingLocationDelegate = printLocation
                settingsViewController.erasingLocationDelegate = eraseLocation
                
                navigationController?.pushViewController(
                    settingsViewController,
                    animated: true
                )
            case 3:
                let settingsViewController = SettingsViewController()
                settingsViewController.settingColorDelegate = changeBackgroundColor
                settingsViewController.settingLocationDelegate = printLocation
                settingsViewController.erasingLocationDelegate = eraseLocation
                
                present(settingsViewController, animated: true, completion: nil)
            default:
                buttonCount = -1
     }
        buttonCount += 1
     }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    
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
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
     }
    
    private func setupLocationToggle() {
        let locationLabel = UILabel()
        settingsView.addArrangedSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.pinTop(to: settingsView.topAnchor, 10)
        locationLabel.pinLeft(to: settingsView.leadingAnchor, 10)
        locationLabel.pinRight(to: settingsView.trailingAnchor, -10)
        
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
    
    private func setupLocationTextView() {
        view.addSubview(locationTextView)
        locationTextView.backgroundColor = .white
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        
        locationTextView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 60)
        
        locationTextView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        
        locationTextView.setHeight(to: 300)
        locationTextView.pinLeft(to: view.leadingAnchor, 15)
        
        locationTextView.isUserInteractionEnabled = false
     }
    
    private func setupSettingsView()
    {
         view.addSubview(setView)
         setView.translatesAutoresizingMaskIntoConstraints = false
         setView.backgroundColor = .systemGray4
         setView.alpha = 0
        
         setView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
         setView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, -10)
       
         setView.setHeight(to: 300)
         setView.widthAnchor.constraint(
         equalTo: setView.heightAnchor,
         multiplier: 2/3
         ).isActive = true

         setView.addSubview(settingsView)
         settingsView.axis = .vertical
         settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        
         settingsView.pinTop(to: setView.topAnchor)
         settingsView.pinLeft(to: setView.leadingAnchor)
         settingsView.pinRight(to: setView.trailingAnchor)
    }
    
    private func setupSettingsButton()
    {
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "setting_logo"), for: .normal)
        
        view.addSubview(settingsButton)
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingsButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        settingsButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 15)
        
        settingsButton.setHeight(to: 30)
        settingsButton.widthAnchor.constraint(
            equalTo: settingsButton.heightAnchor
        ).isActive = true
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),
        for: .touchUpInside)
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
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
     }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate
        else { return }
 
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}

extension ViewController: SettingsDataPass{
    func changeBackgroundColor(color: UIColor) {
        view.backgroundColor = color;
    }
    
    func printLocation(coord: CLLocationCoordinate2D) {
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
    
    func eraseLocation() {
        locationTextView.text = "";
    }
}

