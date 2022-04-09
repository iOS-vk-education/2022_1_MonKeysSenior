//
//  LoginController.swift
//  Drip
//
//  Created by mikh.popov on 09.04.2022.
//

import UIKit

final class LoginViewController: UIViewController {
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.1)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.1)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextFields()
    }

    func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //add stack view as subview to main view with AutoLayout
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 240).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    @objc
    func handleLogin() {
        validateForm()
    }

    @objc
    func handleTextChange() {
        let emailText = emailTextField.text!
        let passwordText = passwordTextField.text!

        let isFormFilled = !emailText.isEmpty && !passwordText.isEmpty

        if isFormFilled {
            signUpButton.backgroundColor = UIColor.orange
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = UIColor.lightGray
            signUpButton.isEnabled = false
        }
        
    }

    func validateForm() {
        guard let emailText = emailTextField.text, !emailText.isEmpty else { return }
        guard let passwordText = passwordTextField.text, !passwordText.isEmpty else { return }

        startLogin(email: emailText, password: passwordText)
    }

    func startLogin(email: String, password: String) {
        print("Please call any Sign up api for registration: ", email, password)
    }
}

