//
//  JoinRoomTableViewController.swift
//  Leaderboards
//
//  Created by JiaChen(: on 3/11/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import UIKit

class JoinRoomTableViewController: UITableViewController, UITextFieldDelegate {
    
    let textField = UITextField()
    
    @IBOutlet weak var codeStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCodeStackView()
        setUpTextField()
    }
    
    func setUpCodeStackView() {
        for i in codeStackView.arrangedSubviews {
            i.layer.cornerRadius = 12
            i.clipsToBounds = true
        }
    }
    
    
    // MARK: - Text field
    func setUpTextField() {
        
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        view.addSubview(textField)
    }
    
    @objc func editingChanged() {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    @IBAction func codeFieldChanged(_ sender: UITextField) {
        if sender.text?.last?.isNumber == false {
            // Sender != number
            
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
