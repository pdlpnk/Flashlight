//
//  ViewController.swift
//  Flashlight
//
//  Created by Рома Подлипняк on 07.10.2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var flashlightButton: UIButton!
    // Button to toggle the flashlight on/off
    @IBOutlet weak var brightnessSlider: UISlider!
    // Slider to adjust flashlight brightness
    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var strobeButton: UIButton!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var screenLightButton: UIButton!
    
    
    // MARK: - Properties
    var device: AVCaptureDevice?
    var flashlightIsOn = true // Track the state of the flashlight

    override func viewDidLoad() {
        super.viewDidLoad()

        brightnessSlider.minimumValue = 0.01 // Set minimum brightness to 0.01
        brightnessSlider.maximumValue = 1.0
        brightnessSlider.value = 1.0 // Default brightness set to maximum
        
        // Get the device for the flashlight
        if let availableDevice = AVCaptureDevice.default(for: .video) {
            device = availableDevice
        }
        
        // Turn on flashlight when app starts
        turnOnFlashlight()
        flashlightButton.setTitle("Turn Off", for: .normal) // Set initial button title
    }
    
    // MARK: - IBActions

    @IBAction func toggleFlashlightButton(_ sender: UIButton) {
        // Change brightness based on button title
        if flashlightIsOn {
            // Set brightness to 0.01 (off)
            setFlashlightBrightness(0.01)
            flashlightButton.setTitle("Turn On", for: .normal)
        } else {
            // Set brightness to the current slider value
            setFlashlightBrightness(brightnessSlider.value)
            flashlightButton.setTitle("Turn Off", for: .normal)
        }
        flashlightIsOn.toggle() // Toggle the state of the flashlight
    }
    // Logic to turn the flashlight on or off
    
    @IBAction func brightnessChangedSlider(_ sender: UISlider) {
        // Update flashlight brightness when the slider value changes
        if flashlightIsOn {
            setFlashlightBrightness(sender.value)
        } else {
            // Optionally show a message to the user
            // For example: showAlert(message: "Please turn on the flashlight to adjust brightness.")
        }
    }
        
        // Logic to handle brightness adjustment
        @IBAction func openSettingsScreenButton(_ sender: UIButton) {
            // Button to navigate to the settings screen
        }
        
        @IBAction func openStrobeScreenButton(_ sender: UIButton) {
            // Button to navigate to the strobe screen
        }
        
        @IBAction func openTimerScreenButton(_ sender: UIButton) {
            // Button to navigate to the timer screen
        }
        
        @IBAction func openScreenLightScreenButton(_ sender: UIButton) {
            // Button to navigate to the screen light mode
        }
        
    // MARK: - Flashlight Functions

    func turnOnFlashlight() {
        guard let device = device, device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            // Set brightness to maximum at startup
            try device.setTorchModeOn(level: brightnessSlider.value)
            device.torchMode = .on // Ensure the flashlight is on
            device.unlockForConfiguration()
        } catch {
            print("Error turning on the flashlight: \(error)")
        }
    }

    func setFlashlightBrightness(_ brightness: Float) {
        guard let device = device, device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            // Set brightness only if greater than or equal to 0.01
            if brightness >= 0.01 {
                try device.setTorchModeOn(level: brightness) // Set brightness based on the slider
            } else {
                device.torchMode = .off // Turn off the flashlight if brightness is less than 0.01
            }
            device.unlockForConfiguration()
        } catch {
            print("Error setting flashlight brightness: \(error)")
        }
    }
}
