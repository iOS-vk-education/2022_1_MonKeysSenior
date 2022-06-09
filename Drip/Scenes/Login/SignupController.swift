import UIKit
import PinLayout

final class SignupViewController: UIViewController {
    let factory = AppFactory()
    
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
    
    let repeatPasswordTextField: TextField = {
        let tf = TextField()
        tf.setupDefault(placeholder: "Repeat password", security: true)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.addTarget(self, action: #selector(handleRepeatPasswordInput), for: .editingChanged)
        return tf
    }()
    
    let repeatPasswordPrompt: PromptLabel = {
        let prompt = PromptLabel()
        prompt.setup(text: "Пароли должны совпадать")
        return prompt
    }()

    let loginButton: Button = {
        let button = Button(type: .system)
        button.setupDefault(title: "Login", titleColor: .white, backgroundColor: .black)
        button.addTarget(self, action: #selector(handlePresentLogin), for: .touchUpInside)
        return button
    }()
    
    let signupButton: Button = {
        let button = Button(type: .system)
        button.setupDefault(title: "Signup", titleColor: .black, backgroundColor: .lightGray)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logo)
        view.addSubview(emailTextField)
        view.addSubview(emailPrompt)
        view.addSubview(passwordTextField)
        view.addSubview(passwordPrompt)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(repeatPasswordPrompt)
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
            .sizeToFit()
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
            .sizeToFit()
            .hCenter()
            .marginTop(1%)
        
        repeatPasswordTextField
            .pin
            .below(of: passwordPrompt)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(1%)
        
        repeatPasswordPrompt
            .pin
            .below(of: repeatPasswordTextField)
            .sizeToFit()
            .hCenter()
            .marginTop(1%)
        
        signupButton
            .pin
            .below(of: repeatPasswordTextField)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(4%)
        
        loginButton
            .pin
            .below(of: signupButton)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(1%)
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
    func handleRepeatPasswordInput() {
        repeatPasswordPrompt.isPrompt()
        let repeatPasswordText = repeatPasswordTextField.text!
        let passwordText = passwordTextField.text!
        if repeatPasswordText.isEmpty || repeatPasswordText != passwordText {
            repeatPasswordPrompt.isError()
        }
    }
    
    @objc
    func handleSignup() {
        validateForm()
    }
    
    @objc
    func handlePresentLogin() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @objc
    func handleTextChange() {
        let emailText = emailTextField.text!
        let passwordText = passwordTextField.text!
        let repeatPasswordText = repeatPasswordTextField.text!

        let isValide = !emailText.isEmpty &&
            !passwordText.isEmpty &&
            !repeatPasswordText.isEmpty &&
            repeatPasswordText == passwordText

        if isValide {
            signupButton.backgroundColor = .white
            signupButton.isEnabled = true
        } else {
            signupButton.backgroundColor = .lightGray
            signupButton.isEnabled = false
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
        guard let repeatPasswordText = repeatPasswordTextField.text, !repeatPasswordText.isEmpty else {
            repeatPasswordPrompt.isError()
            return
        }
        guard passwordText == repeatPasswordText else { return }

        startSignup(email: emailText, password: passwordText)
    }

    func startSignup(email: String, password: String) {
        signupRequest(credentials: Credentials(email: email, password: password)) { (result: Result) in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    let tabBarController = self.factory.buildTabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    tabBarController.modalTransitionStyle = .flipHorizontal
                    self.navigationController?.present(tabBarController, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

