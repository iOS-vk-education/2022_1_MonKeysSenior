import UIKit
import PinLayout

final class ProfileSignupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    let factory = AppFactory()
    var curUser: User?
    var interests: Array<String> = []
    var imgs: Array<String> = []
    
    // picker
    let defaultPicker = UIPickerView()
    var dataForGender = ["", "мужской", "женский"]
    var dataForInterests = ["", "рок","аниме","комедии", "спорт", "наука", "футбол", "реп", "игры"]
    var dataForFavor = ["", "мужчину", "женщину", "все равно"]
    // we have 3 fields with custom picker
    // 0 - picker don't active
    // 1 - gender picker
    // 2 - interests picker
    // 3 - favor picker
    var activeTextField = 0
    
    let logo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Профиль"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = .white
        return label
    }()
    
    let nameTextField: TextField = {
        let field = TextField()
        field.setupDefault(defaultValue: nil, placeholder: "Имя", security: false)
        return field
    }()

    let dateField: TextField = {
        let field = TextField()
        field.setupDefault(defaultValue: nil, placeholder: "Дата рождения", security: false)
        return field
    }()
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -80, to: Date())
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        return datePicker
    }()
    
    let genderField: TextField = {
        let field = TextField()
        field.setupDefault(defaultValue: nil, placeholder: "Пол", security: false)
        return field
    }()
    
    let aboutField: UITextView = {
        let field = UITextView()
        field.text = "Расскажите о себе"
        field.textColor = UIColor.lightGray
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.cornerRadius = 12
        field.font = UIFont.boldSystemFont(ofSize: 14)
        field.backgroundColor = UIColor(white: 0, alpha: 0.1)
        field.textContainerInset = UIEdgeInsets(top: 12.0, left: 5.0, bottom: 0.0, right: 12.0);
        return field
    }()
    
    // hack for placeholder in UITextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Расскажите о себе"
            textView.textColor = UIColor.lightGray
        }
    }

    let interestsField: TextField = {
        let field = TextField()
        field.setupDefault(defaultValue: nil, placeholder: "Интересы", security: false)
        return field
    }()

    let favorField: TextField = {
        let field = TextField()
        field.setupDefault(defaultValue: nil, placeholder: "Предпочтения", security: false)
        return field
    }()
    
    let imgField: UIImageView = {
//        let url = URL(string: imgs[0])
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
//        image.kf.setImage(with: url)
        image.frame = CGRect(x:0, y:0, width: 350, height: 575)
        image.layer.cornerRadius = 12;
        image.clipsToBounds = true
        return image
    }()
    
    let submitBtn: Button = {
        let button = Button(type: .system)
        button.setupDefault(title: "Сохранить", titleColor: .white, backgroundColor: .black)
        button.addTarget(self, action: #selector(touchSubmitBtn), for: .touchUpInside)
        return button
    }()
    
    @objc
    func touchSubmitBtn() {
        if nameTextField.text!.count > 0 {
            curUser?.name = nameTextField.text!
        } else {
            // error
            print("name is empty")
            return
        }
        if nameTextField.text!.count > 0 {
            curUser?.date = dateField.text!
        } else {
            // error
            print("date is empty")
            return
        }
        if genderField.text! == "мужской" {
            curUser?.gender = "male"
        } else if genderField.text! == "женский" {
            curUser?.gender = "female"
        } else {
            // error
            print("undefined gender")
            return
        }
        curUser?.description = aboutField.text!
        curUser?.tags = interests
        if genderField.text! == "мужчину" {
            curUser?.gender = "male"
        } else if genderField.text! == "женщину" {
            curUser?.gender = "female"
        } else {
            print("oh! you are bi")
        }
        updateUser(userData: curUser!)
    }
    
    func updateUser(userData: User) {
        updateProfileRequest(userInfo: userData) { (result: Result) in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "isFullRegistered")
                    let tabBarController = self.factory.buildTabBarController()
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(tabBarController, animated: false, completion: nil)
                }
            case .failure(let error):
                print("ne lol")
                print(error)
            }
        }
    }
    
    func createPickerView() {
        // for custom picker
        defaultPicker.delegate = self
        defaultPicker.delegate?.pickerView?(defaultPicker, didSelectRow: 0, inComponent: 0)
        genderField.inputView = defaultPicker
        interestsField.inputView = defaultPicker
        favorField.inputView = defaultPicker
        defaultPicker.backgroundColor = UIColor(white: 0, alpha: 0.1)
        
        // for default date picker
        dateField.inputView = datePicker
    }
    
    @objc
    func closePickerView() {
        view.endEditing(true)
    }

    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        dateField.inputAccessoryView = toolbar
        genderField.inputAccessoryView = toolbar
        interestsField.inputAccessoryView = toolbar
        favorField.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch activeTextField {
        case 1:
            return dataForGender.count
        case 2:
            return dataForInterests.count
        case 3:
            return dataForFavor.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch activeTextField {
        case 1:
            return dataForGender[row]
        case 2:
            return dataForInterests[row]
        case 3:
            return dataForFavor[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch activeTextField {
        case 1:
            genderField.text = dataForGender[row]
            break
        case 2:
            var deleteTag: Bool = false
            for tag in interests {
                if tag == dataForInterests[row] {
                    deleteTag = true
                    interests = interests.filter { $0 != tag }
                }
            }
            if !deleteTag {
                interests.append(dataForInterests[row])
            }
            interestsField.text = ""
            for tag in interests {
                interestsField.text! += tag + ", "
            }
            break
        case 3:
            favorField.text = dataForFavor[row]
            break
        default:
            break
        }
    }
    
    @objc
    func handleDatePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateField.text = formatter.string(from: datePicker.date)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case genderField:
            activeTextField = 1
            defaultPicker.reloadAllComponents()
        case interestsField:
            activeTextField = 2
            defaultPicker.reloadAllComponents()
        case favorField:
            activeTextField = 3
            defaultPicker.reloadAllComponents()
        default:
            activeTextField = 0
        }
    }
    
    func updateDataInFields(userData: User?) {
        self.nameTextField.text = userData?.name ?? ""
        self.dateField.text = userData?.date ?? ""
        if userData?.gender == "male" {
            self.genderField.text = "мужской"
        } else if userData?.gender == "female" {
            self.genderField.text = "женский"
        } else {
            self.genderField.text = ""
        }
        self.aboutField.text = userData?.description ?? ""
        self.aboutField.textColor = UIColor.white
        if self.aboutField.text == "" {
            self.aboutField.text = "Расскажите о себе"
            self.aboutField.textColor = UIColor.lightGray
        }
        self.interests = userData?.tags ?? []
        for tag in interests {
            self.interestsField.text! += tag + ", "
        }
        if userData?.prefer == "male" {
            self.favorField.text = "мужчину"
        } else if userData?.prefer == "female" {
            self.favorField.text = "женщину"
        } else {
            self.favorField.text = ""
        }
        self.imgs = userData?.imgs ?? []
//        if self.imgs.count > 0 {
//            let url = URL(string: "https://drip.monkeys.team/" + self.imgs[0])
//            self.imgField.kf.setImage(with: url)
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileRequest(completion: { (result: Result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.curUser = result
                    self.updateDataInFields(userData: result)
                    self.view.addSubview(self.logo)
                    self.view.addSubview(self.nameTextField)
                    self.view.addSubview(self.dateField)
                    self.view.addSubview(self.genderField)
                    self.view.addSubview(self.aboutField)
                    self.view.addSubview(self.interestsField)
                    self.view.addSubview(self.favorField)
                    self.view.addSubview(self.imgField)
                    self.view.addSubview(self.submitBtn)
                    self.createPickerView()
                    self.createToolbar()
                    self.dateField.delegate = self
                    self.genderField.delegate = self
                    self.interestsField.delegate = self
                    self.favorField.delegate = self
                    self.aboutField.delegate = self
                }
            case .failure(let error):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    print("error in profile settings: ", error)
                }
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        logo
            .pin
            .top(10%)
            .hCenter()
            .sizeToFit()
        
        nameTextField
            .pin
            .below(of: logo)
            .width(70%)
            .height(5%)
            .hCenter()
            .marginTop(2%)

        dateField
            .pin
            .below(of: nameTextField)
            .width(70%)
            .height(5%)
            .hCenter()
            .marginTop(2%)

        genderField
            .pin
            .below(of: dateField)
            .width(70%)
            .height(5%)
            .hCenter()
            .marginTop(2%)
        
        aboutField
            .pin
            .below(of: genderField)
            .width(70%)
            .height(20%)
            .hCenter()
            .marginTop(2%)
        

        interestsField
            .pin
            .below(of: aboutField)
            .width(70%)
            .height(5%)
            .hCenter()
            .marginTop(2%)

        favorField
            .pin
            .below(of: interestsField)
            .width(70%)
            .height(5%)
            .hCenter()
            .marginTop(2%)
        
        imgField
            .pin
            .below(of: favorField)
            .width(70%)
            .height(5%)
            .hCenter()
            .marginTop(2%)
        
        submitBtn
            .pin
            .below(of: imgField)
            .width(70%)
            .height(5%)
            .hCenter()
            .marginTop(2%)
    }
}
