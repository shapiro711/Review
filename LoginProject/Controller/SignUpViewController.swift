//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by Kim Do hyung on 2021/07/21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var checkPasswordTextFiled: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    let userInformation = UserInformation.shared
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        //nextButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextFiled.becomeFirstResponder()
        addTapGestureInProfileImageView()
        initializeDelegate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func addTapGestureInProfileImageView() {
        let tapGesture = UITapGestureRecognizer()
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
        tapGesture.delegate = self
    }
    
    func initializeDelegate() {
        imagePicker.delegate = self
        idTextFiled.delegate = self
        passwordTextFiled.delegate = self
        checkPasswordTextFiled.delegate = self
        introduceTextView.delegate = self
    }
    
    func checkIsCorrectPassword() -> Bool {
        if userInformation.password == nil || userInformation.password == "" {
            return false
        } else if userInformation.password == checkPasswordTextFiled.text {
            return true
        }
        return false
    }
    
    func checkAndEnalbeNextButton() {
        if profileImageView.image != nil && introduceTextView.text != "" && checkIsCorrectPassword() {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }

    @IBAction func touchUpCancelButton(_ sender: Any) {
        userInformation.resetUserInformation()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNextButton(_ sender: Any) {
        let signUpDetailStoryBoard = UIStoryboard.init(name: "SignUpDetail", bundle: nil)
        let signUpDetailViewController = signUpDetailStoryBoard.instantiateViewController(withIdentifier: "SignUpDetailViewController")
        self.navigationController?.pushViewController(signUpDetailViewController, animated: true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = possibleImage
        }
        
        profileImageView.image = selectedImage
        userInformation.profileImage = selectedImage
        checkAndEnalbeNextButton()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        checkAndEnalbeNextButton()
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        present(imagePicker, animated: true, completion: nil)
        return true
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case idTextFiled:
            userInformation.id = textField.text
        case passwordTextFiled:
            userInformation.password = textField.text
        default:
            break
        }
        checkAndEnalbeNextButton()
    }
}

extension SignUpViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        userInformation.introduce = textView.text
        checkAndEnalbeNextButton()
    }
}
