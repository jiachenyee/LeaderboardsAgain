//
//  ViewController.swift
//  Leaderboards
//
//  Created by JiaChen(: on 2/11/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignUpViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    // UI Elements
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // Sign in with Apple Authentication
    @IBOutlet weak var authStackView: UIStackView!
    
    var identifer: String?
    var username: String?
    var emailAddress: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set up User Interface
        setUpWelcomeLabel()
        setUpSignInWithApple()
    }
    
    func setUpWelcomeLabel() {
        // NSAttributedString for bolding the word Board
        let defaultAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
        let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        
        let attributes = NSMutableAttributedString(string: "Welcome to Board", attributes: defaultAttributes)
        
        attributes.addAttributes(boldAttribute, range: NSRange(location: 10, length: 6))
        
        welcomeLabel.attributedText = attributes
    }
    
    // MARK: Color Test Utility
    var colorTest = 0
    @IBAction func activateColorTest(_ sender: Any) {
        colorTest += 1
        
        if colorTest == 10 {
            colorTest = 0
            performSegue(withIdentifier: "color", sender: nil)
        }
    }
    
    
    // MARK: Sign in with Apple
    func setUpSignInWithApple() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.authStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // ASAuthorizationControllerDelegate
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print(email)
            print(fullName?.givenName)
            
            identifer = userIdentifier
            username = fullName?.givenName
            emailAddress = email
            
            performSegue(withIdentifier: "sign in", sender: nil)
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print(error.localizedDescription)
    }
    
    // ASAuthorizationControllerPresentationContextProviding
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    // Transfer username data over to next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? HomeTableViewController {
            destinationViewController.identifer = self.identifer
            destinationViewController.username = self.username
            destinationViewController.emailAddress = self.emailAddress
        }
    }
}

