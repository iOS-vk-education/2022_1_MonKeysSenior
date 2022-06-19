import UIKit
import PinLayout

final class LoginViewController: UIViewController {
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
        tf.setupDefault(defaultValue: nil, placeholder: "Email", security: false)
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
        tf.setupDefault(defaultValue: nil, placeholder: "Password", security: true)
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
        button.addTarget(self, action: #selector(handlePresentSignup), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProfileRequest() { (result: Result) in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    let tabBarController = self.factory.buildTabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(tabBarController, animated: false, completion: nil)
                }
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.view.addSubview(self.logo)
                    self.view.addSubview(self.emailTextField)
                    self.view.addSubview(self.emailPrompt)
                    self.view.addSubview(self.passwordTextField)
                    self.view.addSubview(self.passwordPrompt)
                    self.view.addSubview(self.loginButton)
                    self.view.addSubview(self.signupButton)
                }
            }
        }
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
    func handlePresentSignup() {
        let signupController = factory.buildSignupViewController()
        signupController.modalTransitionStyle = .flipHorizontal
        signupController.modalPresentationStyle = .fullScreen
        navigationController?.present(signupController, animated: true, completion: nil)
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
        loginRequest(credentials: Credentials(email: email, password: password)) { (result: Result) in
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

