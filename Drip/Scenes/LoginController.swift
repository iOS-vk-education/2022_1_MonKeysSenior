//
//  LoginController.swift
//  Drip
//
//  Created by mikh.popov on 09.04.2022.
//

import UIKit

final class LoginViewController: UIViewController {
    let logo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Drip"
        label.font = UIFont.boldSystemFont(ofSize: 72)
        label.textColor = .white
        return label
    }()

    let emailTextField: UITextField = {
        let tf = TextField()
        tf.setupDefault(placeholder: "Email", security: false)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = TextField()
        tf.setupDefault(placeholder: "Password", security: true)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()

    let loginButton: UIButton = {
        let button = Button(type: .system)
        button.setupDefault(title: "Login", titleColor: .black, backgroundColor: .lightGray)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let signupButton: UIButton = {
        let button = Button(type: .system)
        button.setupDefault(title: "Signup", titleColor: .white, backgroundColor: .black)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLogo()
        setupTextFields()
    }
    
    func setupLogo() {
        view.addSubview(logo)
        logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        logo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        logo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func setupBackground() {
        view.frame = CGRect(x: 0, y: 0, width: 550, height: 844)
        view.backgroundColor = .white
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.059, green: 0.067, blue: 0.235, alpha: 1).cgColor,
          UIColor(red: 0.278, green: 0.161, blue: 0.545, alpha: 1).cgColor,
          UIColor(red: 0.694, green: 0.039, blue: 0.792, alpha: 1).cgColor
        ]
        layer0.locations = [0, 0.46, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1.11, b: 0.82, c: -1, d: -0.29, tx: 1.61, ty: 0.32))
        layer0.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer0.position = view.center
        view.layer.addSublayer(layer0)
    }

    func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //add stack view as subview to main view with AutoLayout
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 240).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
            loginButton.backgroundColor = .white
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .lightGray
            loginButton.isEnabled = false
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

