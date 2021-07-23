//
//  MainViewController.swift
//  LoginProject
//
//  Created by Kim Do hyung on 2021/07/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var idTextfiled: UITextField!
    @IBOutlet weak var passwordTextfiled: UITextField!
    
    let userinformation = UserInformation.shared
    
    override func viewWillAppear(_ animated: Bool) {
        initializeViewValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initializeViewValue() {
        idTextfiled.text = userinformation.id
        passwordTextfiled.text = userinformation.password
    }
    
    @IBAction func touchUpSignUpButton(_ sender: UIButton) {
        let signUpStoryBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let signUpViewController = signUpStoryBoard.instantiateViewController(withIdentifier: "SignUpNavigationController")
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
    }
}
