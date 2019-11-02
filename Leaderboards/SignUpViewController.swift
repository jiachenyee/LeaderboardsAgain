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
    @IBOutlet weak var bodyParagraphLabel: UILabel!
    
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
        setUpBodyParagraphLabel()
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
    
    func setUpBodyParagraphLabel() {
        // NSAttributedString for italics on the last line
        let defaultAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let italicsAttribute = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 15)]
        
        let attributes = NSMutableAttributedString(string: bodyParagraphLabel.text ?? "", attributes: defaultAttributes)
        
        attributes.addAttributes(italicsAttribute, range: NSRange(location: 554, length: 36))
        
        bodyParagraphLabel.attributedText = attributes
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

