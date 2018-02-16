//
//  Signup+Handlers.swift
//  instagram_firebase
//
//  Created by Qichen Huang on 2018-02-15.
//  Copyright © 2018 Qichen Huang. All rights reserved.
//

import UIKit
import Firebase

extension SignupController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(r: 17, g: 154, b: 237)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        }
    }
    
    
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        guard let image = self.plusPhotoButton.imageView?.image else { return }
  
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
           
            if let err = error as NSError? {
                if err.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    print("The email address is already in use by another account")
                } else { print("Inaccurate email formatting") }
                
                print("Failed to create user:", err)
                return
            }
            print("Successfully created user:", user?.uid ?? "")
            
    
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            let filename = NSUUID().uuidString
        Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
            
                if let err = err {
                    print("Failed to upload profile image:", err)
                    return
                }
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                print("Successfully uploaded profile image:", profileImageUrl)
            
            
            
                guard let uid = user?.uid else { return }
                let dictionaryValues = ["username": username, "profileImageUrl": profileImageUrl]
                let values = [uid: dictionaryValues]
            
                self.updateUsersValuesToDatabase(values: values)
            })
        })
    }
    
    private func updateUsersValuesToDatabase(values: [String: Any]) {
        Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print("Failed to save user info into db:", err)
                return
            }
            print("Successfully saved user info to db")
        })
    }
    
    
    
    @objc func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}


