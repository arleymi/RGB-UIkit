//
//  ViewController.swift
//  RGB
//
//  Created by Arthur Lee on 29.06.2021.
//
import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLab: UILabel!
    @IBOutlet var greenLab: UILabel!
    @IBOutlet var blueLab: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 17
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setColor()
        setValueForLabel()
        setValueForTextField()
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
        // Do any additional setup after loading the view.
       }
    
    
    @IBAction func rgbSliders(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLab.text = string(from: sender)
            redTextField.text = string(from: sender)
        case 1:
            greenLab.text = string(from: sender)
            greenTextField.text = string(from: sender)
        case 2:
            blueLab.text = string(from: sender)
            blueTextField.text = string(from: sender)
        default:
            break
        }
        setColor()
    }
    private func setColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    private func setValueForLabel() {
        redLab.text = string(from: redSlider)
        greenLab.text = string(from: redSlider)
        blueLab.text = string(from: blueSlider)
    }
    private func setValueForTextField() {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }

    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text)
        {
            switch textField.tag {
            case 0: redSlider.value = currentValue
            case 1: greenSlider.value = currentValue
            case 2: blueSlider.value = currentValue
            default:break
            }
            setColor()
            setValueForLabel()
        } else {
            showAlert(title: "Wrong format!", message: "Please enter correct value")
        }
    }
}

extension ViewController {
    private func addDoneButtonTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        keyboardToolbar.items = [flexBarButton,doneButton]
    }
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
}
