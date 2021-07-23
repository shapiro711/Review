//
//  SignUpDetailViewController.swift
//  LoginProject
//
//  Created by Kim Do hyung on 2021/07/23.
//

import UIKit

class SignUpDetailViewController: UIViewController {
    @IBOutlet weak var phoneNumberTextFiled: UITextField!
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var joinButton: UIButton!
    
    let userInformation = UserInformation.shared
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        return formatter
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        checkAndEnalbeJoinButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextFiled.delegate = self
        birthDatePicker.addTarget(self, action: #selector(didBirthDatePickerValueChanged(_:)), for: .valueChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func checkAndEnalbeJoinButton() {
        if phoneNumberTextFiled.text != "" && birthDayLabel.text != "" {
            joinButton.isEnabled = true
        } else {
            joinButton.isEnabled = false
        }
    }
    
    func moveToMainViewController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didBirthDatePickerValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let dateString = dateFormatter.string(from: date)
        birthDayLabel.text = dateString
        checkAndEnalbeJoinButton()
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        userInformation.resetUserInformation()
        moveToMainViewController()
    }
    
    @IBAction func touchUpPreviousButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpJoinButton(_ sender: UIButton) {
        moveToMainViewController()
    }
}

extension SignUpDetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        userInformation.phoneNumber = phoneNumberTextFiled.text
        checkAndEnalbeJoinButton()
    }
}


