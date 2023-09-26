//
//  ViewController.swift
//  Lab3MarianaRiosSilveiraCarvalho
//
//  Created by Mariana Rios Silveira Carvalho on 2023-09-23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Private Variables
    private var viewModel: ViewModelProtocol

    // MARK: UI Components
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var ageField: UITextField!

    @IBOutlet weak var informationView: UITextView!

    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: Initializer
    required init?(coder: NSCoder) {
        self.viewModel = ViewModel()
        super.init(coder: coder)
    }
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: Buttons IBActions
    @IBAction func didTapAdd(_ sender: Any) {
        self.viewModel.didTapAdd()
        self.updateLayout()
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        self.viewModel.didTapSubmit()
        self.updateLayout()
    }

    @IBAction func clearButton(_ sender: Any) {
        self.clearFields()
        self.viewModel.didTapClear()
        self.updateLayout()
    }
    
    // MARK: Private Functions
    private func setup() {
        self.setupTextFields()
        self.setupGestures()
        self.updateLayout()
    }

    private func setupTextFields() {
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.countryField.delegate = self
        self.ageField.delegate = self
    }

    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    private func clearFields() {
        self.firstNameField.text = ""
        self.lastNameField.text = ""
        self.countryField.text = ""
        self.ageField.text = ""
    }

    private func updateLayout() {
        self.informationView.text = self.viewModel.information
        self.messageLabel.text = self.viewModel.message

    }

    // MARK: @objc Private Functions
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: UITextField Delegates
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch (textField.tag) {
        case 0:
            self.viewModel.update(name: textField.text ?? "")
        case 1:
            self.viewModel.update(lastName: textField.text ?? "")
        case 2:
            self.viewModel.update(country: textField.text ?? "")
        case 3:
            self.viewModel.update(age: textField.text ?? "")
        default:
            return
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (textField.tag) {
        case 0...2:
            if let nextResponder = textField.superview!.viewWithTag(textField.tag + 1) as? UITextField {
                nextResponder.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        default:
            textField.endEditing(true)
        }

        return false
    }
}
