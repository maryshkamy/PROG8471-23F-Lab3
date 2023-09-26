//
//  ViewModel.swift
//  Lab3MarianaRiosSilveiraCarvalho
//
//  Created by Mariana Rios Silveira Carvalho on 2023-09-24.
//

import Foundation

protocol ViewModelProtocol {
    var information: String { get }
    var message: String { get }

    func update(name: String)
    func update(lastName: String)
    func update(country: String)
    func update(age: String)

    func didTapAdd()
    func didTapSubmit()
    func didTapClear()
}

class ViewModel: ViewModelProtocol {

    // MARK: Private Properties
    private var fullNameFormatted: String {
        "Full Name: \(firstName) \(lastName)"
    }
    private var countryFormatted: String {
        "Country: \(country)"
    }
    private var ageFormatted: String {
        "Age: \(age)"
    }

    private var firstName: String = ""
    private var lastName: String = ""
    private var country: String = ""
    private var age: String = ""

    private var shouldClear: Bool = true

    // MARK: Protocol Properties
    var information: String {
        shouldClear ? "" : "\(fullNameFormatted)\n\(countryFormatted)\n\(ageFormatted)"
    }
    var message: String = ""

    // MARK: Private Functions
    private func areAllFieldsFilledUp() -> Bool {
        if self.firstName.isEmpty || self.lastName.isEmpty || self.country.isEmpty || self.age.isEmpty {
            return false
        }

        return true
    }

    // MARK: Protocol Functions
    func update(name: String) {
        self.firstName = name
    }

    func update(lastName: String) {
        self.lastName = lastName
    }

    func update(country: String) {
        self.country = country
    }

    func update(age: String) {
        self.age = age
    }

    func didTapAdd() {
        self.shouldClear = false
        self.message = areAllFieldsFilledUp() ? "" : "Complete the missing Info!"
    }

    func didTapSubmit() {
        self.shouldClear = false
        self.message = areAllFieldsFilledUp() ? "Successfully submitted!" : "Complete the missing Info!"
    }

    func didTapClear() {
        self.shouldClear = true
        self.message = ""

        self.firstName = ""
        self.lastName = ""
        self.country = ""
        self.age = ""
    }
}
