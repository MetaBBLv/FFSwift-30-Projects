//
//  CreateContactViewController.swift
//  FFBirthdays
//
//  Created by zhou on 2019/7/25.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import Contacts


class CreateContactViewController: UIViewController {

    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtHomeEmail: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        let saveVarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(CreateContactViewController.createContact))
        navigationItem.rightBarButtonItem = saveVarButtonItem
    }
    
    // MARK: Custom functions
    @objc func createContact() {
        let newContact = CNMutableContact()
        
        newContact.givenName = txtFirstname.text!
        newContact.familyName = txtFirstname.text!
        
        if let homeEmail = txtHomeEmail.text {
            let homeEmail = CNLabeledValue(label: CNLabelHome, value: homeEmail as NSString)
            newContact.emailAddresses = [homeEmail]
        }
        
        let birthdayComponents = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: datePicker.date)
        newContact.birthday = birthdayComponents
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.add(newContact, toContainerWithIdentifier: nil)
            try AppDelegate.appDelegate.contactStore.execute(saveRequest)
            navigationController?.popViewController(animated: true)
        } catch {
            Helper.show(message: "Unable to save the new contact")
        }
    }
}

// MARK: UITextFieldDelegate functions
extension CreateContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
