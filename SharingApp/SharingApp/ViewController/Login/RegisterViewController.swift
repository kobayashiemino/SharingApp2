//
//  RegisterViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/08.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8
    }
    
    private let profileIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "plus")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.tintColor = .lightGray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "username"
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "email"
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(profileIconImageView)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapIconImageView))
        profileIconImageView.addGestureRecognizer(gesture)
        
        registerButton.addTarget(self, action: #selector(didTapregisterButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileIconImageView.frame = CGRect(x: 0,
                                            y: 50,
                                            width: 100,
                                            height: 100)
        profileIconImageView.center.x = view.center.x
        profileIconImageView.layer.cornerRadius = profileIconImageView.width / 2
        
        usernameTextField.frame = CGRect(x: 10,
                                         y: profileIconImageView.bottom + 20,
                                         width: view.width - 20,
                                         height: 52)
        emailTextField.frame = CGRect(x: 10,
                                      y: usernameTextField.bottom + 10,
                                      width: view.width - 20,
                                      height: 52)
        passwordTextField.frame = CGRect(x: 10,
                                         y: emailTextField.bottom + 10,
                                         width: view.width - 20,
                                         height: 52)
        registerButton.frame = CGRect(x: 10,
                                      y: passwordTextField.bottom + 10,
                                      width: view.width - 20,
                                      height: 52)
    }
    
    @objc private func didTapIconImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc private func didTapregisterButton() {
        
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        guard let image = profileIconImageView.image else { return }
        guard let imageData = image.pngData() else { return }
        
        let values:[String: Any] = ["profilePicture": imageData,
                                    "username": username,
                                    "email": email,
                                    "password": password]
        
        AuthManeger.shared.registerNewUser(values: values) { (registerd) in
            if registerd {
                `self`.dismiss(animated: true, completion: nil)
            } else {
                print("failed to register new user")
            }
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            didTapregisterButton()
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        profileIconImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
