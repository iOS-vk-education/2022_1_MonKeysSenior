//
//  LoginController.swift
//  Drip
//
//  Created by mikh.popov on 09.04.2022.
//

import UIKit
import PinLayout

final class LoginViewController: UIViewController {
    let logo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Drip"
        label.font = UIFont.boldSystemFont(ofSize: 72)
        label.textColor = .white
        return label
    }()

    let emailTextField: TextField = {
        let tf = TextField()
        tf.setupDefault(placeholder: "Email", security: false)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.addTarget(self, action: #selector(handleEmailInput), for: .editingChanged)
        return tf
    }()
    
    let emailPrompt: PromptLabel = {
        let prompt = PromptLabel()
        prompt.setup(text: "Введите почту в формате drip@example.com")
        return prompt
    }()
    
    let passwordTextField: TextField = {
        let tf = TextField()
        tf.setupDefault(placeholder: "Password", security: true)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.addTarget(self, action: #selector(handlePasswordInput), for: .editingChanged)
        return tf
    }()
    
    let passwordPrompt: PromptLabel = {
        let prompt = PromptLabel()
        prompt.setup(text: "Пароль должен быть не короче 8 символов")
        return prompt
    }()

    let loginButton: Button = {
        let button = Button(type: .system)
        button.setupDefault(title: "Login", titleColor: .black, backgroundColor: .lightGray)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let signupButton: Button = {
        let button = Button(type: .system)
        button.setupDefault(title: "Signup", titleColor: .white, backgroundColor: .black)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        view.addSubview(logo)
        view.addSubview(emailTextField)
        view.addSubview(emailPrompt)
        view.addSubview(passwordTextField)
        view.addSubview(passwordPrompt)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logo
            .pin
            .top(10%)
            .hCenter()
            .sizeToFit()
        
        emailTextField
            .pin
            .below(of: logo)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(10%)
        
        emailPrompt
            .pin
            .below(of: emailTextField)
            .width(50%)
            .height(1%)
            .hCenter()
            .marginTop(1%)
        
        passwordTextField
            .pin
            .below(of: emailPrompt)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(1%)
        
        passwordPrompt
            .pin
            .below(of: passwordTextField)
            .width(50%)
            .height(1%)
            .hCenter()
            .marginTop(1%)
        
        loginButton
            .pin
            .below(of: passwordPrompt)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(4%)
        
        signupButton
            .pin
            .below(of: loginButton)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(1%)
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

    @objc
    func handleEmailInput() {
        emailPrompt.isPrompt()
        let emailText = emailTextField.text!
//        let regex = try! NSRegularExpression(pattern: #"^\S+@\S+\.\S+$"#, options: .caseInsensitive)
        if emailText.isEmpty
//            || regex.firstMatch(in: emailText, options: [], range: NSRange(location: 0, length: emailText.count)) != nil
        {
            emailPrompt.isError()
        }
    }
    
    @objc
    func handlePasswordInput() {
        passwordPrompt.isPrompt()
        let passwordText = passwordTextField.text!
        if passwordText.count < 8 {
            passwordPrompt.isError()
        }
    }
    
    @objc
    func handleLogin() {
        validateForm()
    }

    @objc
    func handleTextChange() {
        let emailText = emailTextField.text!
        let passwordText = passwordTextField.text!

        let isValide = !emailText.isEmpty && !passwordText.isEmpty

        if isValide {
            loginButton.backgroundColor = .white
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .lightGray
            loginButton.isEnabled = false
        }
        
    }

    func validateForm() {
        guard let emailText = emailTextField.text, !emailText.isEmpty else {
            emailPrompt.isError()
            return
        }
        guard let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            passwordPrompt.isError()
            return
        }

        startLogin(email: emailText, password: passwordText)
    }

    func startLogin(email: String, password: String) {
        print("Please call any Login api for login: ", email, password)
    }
}

