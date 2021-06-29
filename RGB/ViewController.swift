//
//  ViewController.swift
//  RGB
//
//  Created by Arthur Lee on 29.06.2021.
//
import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet var colourView: UIView!
    
    @IBOutlet var redLab: UILabel!
    @IBOutlet var greenLab: UILabel!
    @IBOutlet var blueLab: UILabel!
    
    @IBOutlet var redSlide: UISlider!
    @IBOutlet var greenSlide: UISlider!
    @IBOutlet var blueSlide: UISlider!
    
    @IBOutlet var redTextFieldOne: UITextField!
    @IBOutlet var greeenTextFIeldOne: UITextField!
    
    @IBOutlet var blueTextFieldOne: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colourView.layer.cornerRadius = 17
        
        redSlide.tintColor = .red
        greenSlide.tintColor = .green
        
        setColor()
        setValueForLabel()
        setValueForTextField()
        addDoneButtonTo(redTextFieldOne)
        addDoneButtonTo(greeenTextFIeldOne)
        addDoneButtonTo(blueTextFieldOne)
        
        // Do any additional setup after loading the view.
       }
    
    
    @IBAction func rgbSliders(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLab.text = string(from: sender)
            redTextFieldOne.text = string(from: sender)
        case 1:
            greenLab.text = string(from: sender)
            greeenTextFIeldOne.text = string(from: sender)
        case 2:
            blueLab.text = string(from: sender)
            blueTextFieldOne.text = string(from: sender)
        default:
            break
        }
        setColor()
    }
    private func setColor() {
        colourView.backgroundColor = UIColor(red: CGFloat(redSlide.value), green: CGFloat(greenSlide.value), blue: CGFloat(blueSlide.value), alpha: 1)
    }
    private func setValueForLabel() {
        redLab.text = string(from: redSlide)
        greenLab.text = string(from: redSlide)
        blueLab.text = string(from: blueSlide)
    }
    private func setValueForTextField() {
        redTextFieldOne.text = string(from: redSlide)
        greeenTextFIeldOne.text = string(from: greenSlide)
        blueTextFieldOne.text = string(from: blueSlide)
    }

    private func string(from slide: UISlider) -> String {
        return String(format: "%.2f", slide.value)
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
            case 0: redSlide.value = currentValue
            case 1: greenSlide.value = currentValue
            case 2: blueSlide.value = currentValue
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
