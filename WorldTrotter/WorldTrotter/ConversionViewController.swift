//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Kukuh Yoniatmoko on 19/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {

    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()

    @IBOutlet var fahrenheitTextField: UITextField!
    @IBOutlet var celsiusLabel: UILabel!

    private var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusTextLabel()
        }
    }

    private var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }

    @IBAction func fahrenheitFieldEditingChanged(_ textFiled: UITextField) {
        if let text = textFiled.text, let value = numberFormatter.number(from: text)?.doubleValue {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }

    private func updateCelsiusTextLabel() {
        if let celsius = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsius.value))
        } else {
            celsiusLabel.text = "???"
        }
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        fahrenheitTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let existingTextHasDecimalSeparator = textField.text?.contains(decimalSeparator) ?? false
        let replacementTextHasDecimalSeparator = string.contains(decimalSeparator)
        if existingTextHasDecimalSeparator && replacementTextHasDecimalSeparator {
            return false
        }

        let replacementTextHasLetterCharacters = string.rangeOfCharacter(from: .letters) != nil
        return !replacementTextHasLetterCharacters
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusTextLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Date().hashValue % 2 == 0 {
            view.backgroundColor = UIColor.darkGray
        } else {
            view.backgroundColor = UIColor.lightGray
        }
    }
}
