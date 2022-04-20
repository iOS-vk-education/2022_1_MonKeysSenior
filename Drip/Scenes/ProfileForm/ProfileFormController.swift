//
//  ProfileFormController.swift
//  Drip
//
//  Created by User1 on 19.04.2022.
//

import Foundation
import UIKit
import PinLayout

final class ProfileFormController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    
    var dataObject : [String] = ["Мужской","Женский","Х"];
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -80, to: Date())
        return datePicker
    }()
    
    let genderPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Профиль"
        label.textColor = .white
        label.font = label.font.withSize(30)
        return label
    }()
    
    let nameTextField: TextField = {
        let field = TextField()
        field.setupDefault(placeholder: "Имя", security: false)
//        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
//        tf.addTarget(self, action: #selector(handleEmailInput), for: .editingChanged)
        return field
    }()
    
    let dateField: TextField = {
        let field = TextField()
        field.setupDefault(placeholder: "Дата рождения", security: false)
//        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
//        tf.addTarget(self, action: #selector(handleEmailInput), for: .editingChanged)
        return field
    }()
    
    let genderField: TextField = {
        let field = TextField()
        field.setupDefault(placeholder: "Пол", security: false)
//        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
//        tf.addTarget(self, action: #selector(handleEmailInput), for: .editingChanged)
        return field
    }()
    
    let toolbar = UIToolbar()
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
    
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(goBack))
        
        view.addGestureRecognizer(swipeLeft)
        
        title = "Settings"
        
        view.addSubview(mainLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateField)
        view.addSubview(genderField)
        
        self.nameTextField.delegate = self
        
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        dateField.inputView = datePicker
        toolbar.setItems([flexSpace, doneBtn], animated: true)
        toolbar.sizeToFit()
        
        self.genderField.inputView = genderPicker
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        
        dateField.inputAccessoryView = toolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    @objc
    func dateChange() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: datePicker.date)
    }
    
    @objc
    func doneAction() {
        view.endEditing(true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        print(datePicker.date)
        print(dateField.text!)
        
        mainLabel.pin
            .hCenter()
            .top(view.pin.safeArea + 15)
            .sizeToFit()
        
        nameTextField
            .pin
            .below(of: mainLabel)
            .width(50%)
            .height(5%)
            .hCenter()
            .marginTop(10)
    
        
        dateField.pin
            .below(of: nameTextField)
            .hCenter()
            .height(5%)
            .width(50%)
            .marginTop(10)
        
        genderField.pin
            .below(of: dateField)
            .hCenter()
            .height(5%)
            .width(50%)
            .marginTop(10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    func setGradientBackground() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
                  UIColor(red: 0.059, green: 0.067, blue: 0.235, alpha: 1).cgColor,
                  UIColor(red: 0.278, green: 0.161, blue: 0.545, alpha: 1).cgColor,
                  UIColor(red: 0.694, green: 0.039, blue: 0.792, alpha: 1).cgColor
                ]
        layer0.locations = [0, 0.46, 1]
        layer0.startPoint = CGPoint(x: 0, y: 0)
        layer0.endPoint = CGPoint(x: 1, y: 1)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 5, c: -1, d: 0, tx: 1, ty: 1))
//        layer0.position = window!.center
        view?.layer.insertSublayer(layer0, at:0)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataObject.count;
    }

    private func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.dataObject[row];
    }

    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderField.text = self.dataObject[row];
        self.genderField.endEditing(true)
    }
    
    @objc
    private func goBack() {
        dismiss(animated: true)
    }
}
