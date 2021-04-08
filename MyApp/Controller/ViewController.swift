//
//  ViewController.swift
//  WeatherApp
//
//  Created by Elena on 31.03.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGextureRecognozer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGextureRecognozer)
    }
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView?
    @IBAction func buttonLoginPressed(_ sender: Any) {
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
        
        if  usernameTextField.text == "admin",
            passwordTextField.text == "12345" {
            print("Auth's successed")
        }
        else {
            print("Auth's denied")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
            // Второе — когда она пропадает
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }


    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    private func CheckUserInfo() -> Bool {
        guard
            let username = usernameTextField.text,
            let password = passwordTextField.text,
            username == "admin",
            password == "12345"
        else {
            loginError()
            return false }
        return true
        
        
    }
    private func loginError(with mistake: String = "Некорректный логин или пароль") {
        let alertController = UIAlertController(title: "Error", message: mistake, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okButton)
        present(alertController,
                animated: true) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    //метод для переходов
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        CheckUserInfo()
    }
    
    
    
    //=========================================
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
    // Когда клавиатура появляется
        @objc func keyboardWasShown(notification: Notification) {

            // Получаем размер клавиатуры
            let info = notification.userInfo! as NSDictionary
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
            self.scrollView?.contentInset = contentInsets
            scrollView?.scrollIndicatorInsets = contentInsets
        }

        //Когда клавиатура исчезает
        @objc func keyboardWillBeHidden(notification: Notification) {
            // Устанавливаем отступ внизу UIScrollView, равный 0
            let contentInsets = UIEdgeInsets.zero
            scrollView?.contentInset = contentInsets
        }

  



    
}

